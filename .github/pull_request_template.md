## What and why

<!-- One or two sentences. Link the plan (docs/plans/NNNN-...) or issue (Closes #12). -->

## How to test

<!-- Steps a reviewer can follow, or "covered by tests". -->

## Checklist

- [ ] PR title follows Conventional Commits (`feat(auth): add login screen`); it becomes the changelog line
- [ ] Targets `dev` (only `dev` or a `hotfix/*` branch may target `main`)
- [ ] Tests added or updated first; `domain/` and `data/` stay at or above 80 % coverage
- [ ] `dart format .`, `flutter analyze --fatal-infos` and `flutter test` pass locally
- [ ] No user-visible strings in code (they live in `lib/l10n/*.arb`)
- [ ] No secrets, keys or personal data added; new network calls use HTTPS with a timeout
- [ ] New dependencies are justified below (maintenance, publisher, licence)
- [ ] Docs updated where behaviour or structure changed:
  - [ ] `CHANGELOG.md` under *Unreleased*
  - [ ] `docs/architecture/` for structural changes
  - [ ] a new ADR in `docs/decisions/` for any non-obvious choice

## New dependencies

<!-- Name, why, alternatives considered. Delete if none. -->

## Screenshots

<!-- For UI changes. Delete if none. -->
