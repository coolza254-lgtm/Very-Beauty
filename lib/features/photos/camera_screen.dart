import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/labels.dart';
import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/storage/app_paths.dart';
import '../../core/storage/photo_storage.dart';
import '../../core/utils/date_utils.dart';

const _cameraExplainedKey = 'camera_explained';

/// Face camera with an oval guide and the previous photo faded on top
/// ("onion skin") so each photo is taken from the same position
/// (docs/SPEC.md §7.5). No image analysis.
class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  List<CameraDescription> _cameras = const [];
  int _index = 0;
  CameraController? _controller;
  String? _onionPath;
  bool _showOnion = true;
  bool _saving = false;
  String? _error;
  late TimeOfDaySlot _session = DateTime.now().hour < 15
      ? TimeOfDaySlot.morning
      : TimeOfDaySlot.evening;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _controller = null;
      controller.dispose();
    } else if (state == AppLifecycleState.resumed && _cameras.isNotEmpty) {
      _open(_cameras[_index]);
    }
  }

  Future<void> _start() async {
    final l10n = AppLocalizations.of(context);
    final settings = ref.read(settingsDaoProvider);
    if (await settings.getValue(_cameraExplainedKey) == null) {
      if (!mounted) return;
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.photo_camera_outlined),
          title: Text(l10n.cameraPermissionTitle),
          content: Text(l10n.cameraPermissionBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.actionCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.actionContinue),
            ),
          ],
        ),
      );
      if (ok != true) {
        if (mounted) context.pop();
        return;
      }
      await settings.setValue(_cameraExplainedKey, '1');
    }

    final paths = await ref.read(appPathsProvider.future);
    final last = await ref.read(photosDaoProvider).latest();
    if (last != null) _onionPath = paths.resolve(last.filePath);

    try {
      _cameras = await availableCameras();
    } on CameraException catch (e) {
      return _fail(e);
    }
    if (!mounted) return;
    if (_cameras.isEmpty) {
      setState(() => _error = l10n.cameraUnavailable);
      return;
    }
    final front = _cameras.indexWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
    );
    _index = front < 0 ? 0 : front;
    await _open(_cameras[_index]);
  }

  Future<void> _open(CameraDescription camera) async {
    final previous = _controller;
    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    setState(() => _controller = null);
    await previous?.dispose();
    try {
      await controller.initialize();
      await controller.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      await controller.dispose();
      return _fail(e);
    }
    if (!mounted) {
      await controller.dispose();
      return;
    }
    setState(() {
      _controller = controller;
      _error = null;
    });
  }

  void _fail(CameraException e) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    setState(
      () => _error = e.code.contains('Access') || e.code.contains('ermission')
          ? l10n.cameraDenied
          : e.description ?? e.code,
    );
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || _saving || controller.value.isTakingPicture) {
      return;
    }
    setState(() => _saving = true);
    final l10n = AppLocalizations.of(context);
    try {
      final shot = await controller.takePicture();
      final bytes = await shot.readAsBytes();
      final now = DateTime.now();
      final paths = await ref.read(appPathsProvider.future);
      final stored = await PhotoStorage(paths).save(
        bytes,
        takenAt: now,
        mirror:
            controller.description.lensDirection == CameraLensDirection.front,
      );
      // The plugin's temporary file still has the original metadata.
      try {
        await File(shot.path).delete();
      } on FileSystemException catch (_) {
        // Temporary file already gone; nothing to clean up.
      }
      await ref
          .read(photosDaoProvider)
          .addPhoto(
            date: toDateKey(now),
            takenAt: now,
            filePath: stored.filePath,
            thumbPath: stored.thumbPath,
            session: _session,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.cameraSaved)));
      context.pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = _controller;
    final ready = controller != null && controller.value.isInitialized;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (ready) _CoverPreview(controller: controller),
          if (ready && _showOnion && _onionPath != null)
            IgnorePointer(
              child: Opacity(
                opacity: 0.35,
                child: Image.file(
                  File(_onionPath!),
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox(),
                ),
              ),
            ),
          const IgnorePointer(child: CustomPaint(painter: _OvalGuidePainter())),
          if (_error != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          else if (!ready)
            const Center(child: CircularProgressIndicator()),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 16, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 4),
                      Expanded(child: _TipBanner(text: l10n.cameraTip)),
                    ],
                  ),
                ),
                const Spacer(),
                _Controls(
                  saving: _saving,
                  canSwitch: _cameras.length > 1,
                  hasOnion: _onionPath != null,
                  showOnion: _showOnion,
                  sessionLabel: l10n.slot(_session),
                  onToggleOnion: () => setState(() => _showOnion = !_showOnion),
                  onCycleSession: () => setState(
                    () => _session =
                        TimeOfDaySlot.values[(_session.index + 1) %
                            TimeOfDaySlot.values.length],
                  ),
                  onCapture: ready ? _capture : null,
                  onSwitch: () {
                    _index = (_index + 1) % _cameras.length;
                    _open(_cameras[_index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Camera preview scaled to fill the screen (cropping the edges).
class _CoverPreview extends StatelessWidget {
  const _CoverPreview({required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    final size = controller.value.previewSize;
    if (size == null) return CameraPreview(controller);
    // previewSize is reported in landscape; the screen is portrait.
    return ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: size.shortestSide,
          height: size.longestSide,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}

class _TipBanner extends StatelessWidget {
  const _TipBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.wb_twilight_rounded, color: Colors.white, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}

class _Controls extends StatelessWidget {
  const _Controls({
    required this.saving,
    required this.canSwitch,
    required this.hasOnion,
    required this.showOnion,
    required this.sessionLabel,
    required this.onToggleOnion,
    required this.onCycleSession,
    required this.onCapture,
    required this.onSwitch,
  });

  final bool saving;
  final bool canSwitch;
  final bool hasOnion;
  final bool showOnion;
  final String sessionLabel;
  final VoidCallback onToggleOnion;
  final VoidCallback onCycleSession;
  final VoidCallback? onCapture;
  final VoidCallback onSwitch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    const white = Colors.white;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          ActionChip(
            avatar: const Icon(Icons.schedule_rounded, size: 18),
            label: Text(sessionLabel),
            onPressed: onCycleSession,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _RoundButton(
                tooltip: l10n.cameraOnionSkin,
                icon: showOnion ? Icons.layers_rounded : Icons.layers_outlined,
                active: showOnion,
                onTap: hasOnion ? onToggleOnion : null,
              ),
              Semantics(
                button: true,
                label: l10n.cameraCapture,
                child: GestureDetector(
                  onTap: saving ? null : onCapture,
                  child: Container(
                    width: 78,
                    height: 78,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: white, width: 4),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: saving ? scheme.primary : white,
                      ),
                      child: saving
                          ? const Padding(
                              padding: EdgeInsets.all(18),
                              child: CircularProgressIndicator(color: white),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              _RoundButton(
                tooltip: l10n.cameraSwitch,
                icon: Icons.cameraswitch_rounded,
                onTap: canSwitch ? onSwitch : null,
              ),
            ],
          ),
          if (saving) ...[
            const SizedBox(height: 12),
            Text(l10n.cameraSaving, style: const TextStyle(color: white)),
          ],
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
    this.active = false,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) => IconButton.filled(
    tooltip: tooltip,
    onPressed: onTap,
    iconSize: 26,
    style: IconButton.styleFrom(
      backgroundColor: active
          ? Theme.of(context).colorScheme.primary
          : Colors.black.withValues(alpha: 0.4),
      foregroundColor: Colors.white,
      disabledBackgroundColor: Colors.black.withValues(alpha: 0.2),
      minimumSize: const Size(52, 52),
    ),
    icon: Icon(icon),
  );
}

/// Dims everything outside an oval where the face should go.
class _OvalGuidePainter extends CustomPainter {
  const _OvalGuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width * 0.68;
    final h = w * 1.32;
    final oval = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.44),
      width: w,
      height: h,
    );
    final outside = Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & size),
      Path()..addOval(oval),
    );
    canvas.drawPath(
      outside,
      Paint()..color = Colors.black.withValues(alpha: 0.35),
    );
    canvas.drawOval(
      oval,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..color = Colors.white.withValues(alpha: 0.9),
    );
  }

  @override
  bool shouldRepaint(covariant _OvalGuidePainter oldDelegate) => false;
}
