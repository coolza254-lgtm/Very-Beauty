import 'package:flutter/material.dart';

import '../../app/l10n/gen/app_localizations.dart';
import '../../app/widgets/empty_state_view.dart';

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navPhotos)),
      body: EmptyStateView(
        icon: Icons.photo_camera_outlined,
        title: l10n.photosEmptyTitle,
        body: l10n.photosEmptyBody,
      ),
    );
  }
}
