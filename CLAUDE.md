# Very Beauty — notes for Claude Code

- The source of truth is `docs/SPEC.md`. Read it before starting work and follow its
  principles (offline-first, privacy, few taps) above everything else.
- Work phase by phase (§11). Ask the user before deciding anything the spec leaves open.
- Code, identifiers and code comments in English; UI strings in Thai via ARB
  (`lib/app/l10n/app_th.arb` is the template, keep `app_en.arb` in sync).
- After changing drift tables: bump `schemaVersion`, write the migration step, run
  `dart run drift_dev make-migrations`, and update `docs/SPEC.md` §5.
- Generated code (`*.g.dart`, `lib/app/l10n/gen/`) is committed; regenerate with
  `dart run build_runner build` and `flutter gen-l10n`.
- Before pushing: `dart format lib test`, `flutter analyze`, `flutter test`.
- Tests: `test/helpers/pump_app.dart` pumps the whole app with an in-memory DB and
  fakes for notifications/updates (never hit the network or platform plugins);
  `test/helpers/demo_data.dart` seeds realistic data. Long lists are lazy — scroll
  (`tapVisible`) before tapping. Unmount before closing the DB (pumpApp does this).
- Design review: `flutter test test/screenshots --update-goldens --dart-define=SCREENSHOTS=true`
  writes phone-size PNGs to `build/screenshots/`.
- Re-running `flutter_native_splash:create` rewrites `android/app/src/main/res/values*/styles.xml`;
  keep the AppCompat parents (needed by local_auth).
- The ingredient database `assets/data/ingredients.json` is generated: edit
  `tool/ingredients/data_*.py` and run `python3 tool/ingredients/build.py` (needs RDKit).
