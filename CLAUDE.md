# CLAUDE.md

Flutter/Dart app template (Android first, iOS from the same code) with git flow, CI/CD, security checks and this Claude Code setup. Replace this paragraph with what the app does once the project is initialised (`tool/init_project.sh`).

## Source of truth

| Where | What it owns |
|---|---|
| `.claude/rules/` | Coding, testing, git and environment, security, documentation rules. They always apply. |
| `docs/architecture/` | How the app and the pipelines are built |
| `docs/decisions/` | Why it is built that way (ADRs) |
| `docs/plans/` | The work in progress, with acceptance criteria |
| `CHANGELOG.md` | What changed for users, per version |

If code and docs disagree, ask. Do not silently pick one. Put open questions in the PR description.

## Stack

Flutter stable (CI pins `FLUTTER_VERSION` in `.github/workflows/`), Dart 3.9+, Material 3 via `material_ui` (Material moved out of `package:flutter` in Flutter 3.47+), `flutter_riverpod` (no codegen), `flutter_localizations` + ARB files. Add packages only with a reason (see `.claude/rules/common/security.md`).

## Layout (feature-first, layered)

```text
lib/
  main.dart, app.dart          bootstrap, ProviderScope, theme, env banner
  core/                        config (AppEnv), theme tokens, logging, utils. No feature imports.
  features/<feature>/
    domain/                    pure Dart: entities, value objects, repository interfaces
    data/                      repository implementations, DTOs, parsers, IO
    application/               Riverpod providers and notifiers
    ui/                        screens and widgets only
  l10n/app_en.arb              every user-visible string
test/                          mirrors lib/, helpers in test/support/
tool/                          repo scripts (setup, coverage, docs index, release)
```

Dependency direction: `ui -> application -> domain <- data`. `lib/features/counter/` is the reference implementation of every layer.

## Commands

```bash
flutter pub get
dart format .
flutter analyze --fatal-infos
flutter test --coverage && bash tool/coverage_check.sh
python tool/docs_index.py          # after adding or renaming docs
flutter run --dart-define=APP_ENV=dev
```

## Workflow

- **Branches:** `<type>/<slug>` from `dev` -> PR into `dev` (squash) -> release PR `dev` -> `main` (merge commit) -> automatic tag and release. `dev` is the dev environment and `main` is prod. Never commit or push to `dev` or `main`. See `.claude/rules/common/git-workflow.md`.
- **Conventional Commits** for commits and PR titles (`feat(auth): add login screen`).
- **TDD** for logic. **Definition of done:** format, analyze and tests green; `domain/` + `data/` coverage of at least 80 %; CHANGELOG and docs updated; `/verify` passes.
- **Agents** in `.claude/agents/` and commands `/plan`, `/tdd`, `/feature`, `/verify`, `/review`, `/build-fix`, `/adr`, `/release`. See `.claude/rules/common/agents.md`.
- Claude opens PRs. The owner merges them and owns releases.
