import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/theme.dart';
import '../db/providers.dart';
import '../db/settings_dao.dart';
import 'app_lock.dart';

/// Covers the app with a lock screen when app lock is on: at launch and
/// after the app has been in the background for more than [grace].
class LockGate extends ConsumerStatefulWidget {
  const LockGate({
    super.key,
    required this.child,
    this.grace = const Duration(seconds: 30),
  });

  final Widget child;
  final Duration grace;

  @override
  ConsumerState<LockGate> createState() => _LockGateState();
}

class _LockGateState extends ConsumerState<LockGate> {
  late final AppLifecycleListener _lifecycle;

  /// Decided on the first settings load: locked at launch if the lock is
  /// on. Turning the lock on later doesn't lock the current session.
  bool? _locked;
  bool _authenticating = false;

  /// The system prompt opens by itself once per lock; after that the user
  /// taps "Unlock" (so cancelling never loops).
  bool _autoPrompted = false;
  DateTime? _hiddenAt;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onHide: () {
        if (!_authenticating) _hiddenAt ??= DateTime.now();
      },
      onResume: () {
        final hiddenAt = _hiddenAt;
        _hiddenAt = null;
        if (hiddenAt != null &&
            DateTime.now().difference(hiddenAt) > widget.grace) {
          setState(() {
            _locked = true;
            _autoPrompted = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  bool get _enabled =>
      ref.read(settingsProvider).value?[SettingKeys.appLock] == '1';

  Future<void> _unlock() async {
    if (_authenticating || !_enabled) return;
    _authenticating = true;
    final l10n = AppLocalizations.of(context);
    final ok = await ref.read(deviceAuthProvider).authenticate(l10n.lockReason);
    _authenticating = false;
    _hiddenAt = null;
    if (ok && mounted) setState(() => _locked = false);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    // Wait for settings so the content never flashes before the lock.
    if (!settings.hasValue) {
      return const ColoredBox(color: BrandColors.porcelain);
    }
    final enabled = settings.value![SettingKeys.appLock] == '1';
    final locked = _locked ??= enabled;
    if (!enabled || !locked) return widget.child;

    if (!_autoPrompted) {
      _autoPrompted = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _unlock());
    }
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 56,
                backgroundColor: BrandColors.blush,
                backgroundImage: AssetImage('assets/branding/face_round.png'),
              ),
              const SizedBox(height: 24),
              Text(l10n.lockTitle, style: theme.textTheme.titleLarge),
              const SizedBox(height: 24),
              FilledButton.icon(
                icon: const Icon(Icons.lock_open_rounded),
                label: Text(l10n.lockUnlock),
                onPressed: _unlock,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
