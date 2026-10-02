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
