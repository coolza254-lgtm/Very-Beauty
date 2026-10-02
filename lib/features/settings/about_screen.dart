import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../app/l10n/gen/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsAbout)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                'assets/branding/logo.png',
                width: 160,
                height: 160,
              ),
            ),
          ),
          const SizedBox(height: 12),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) => Text(
              snapshot.hasData
                  ? l10n.aboutVersion(
                      '${snapshot.data!.version}+${snapshot.data!.buildNumber}',
                    )
                  : '',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.aboutDisclaimerTitle, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(l10n.aboutDisclaimer),
          const SizedBox(height: 24),
          Text(l10n.aboutPrivacyTitle, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(l10n.aboutPrivacy),
        ],
      ),
    );
  }
}
