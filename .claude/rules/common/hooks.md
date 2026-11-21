# Hooks

## Claude Code hooks (`.claude/settings.json`)

- **PreToolUse (Bash), `guard-git.sh`:** blocks pushes to `main`/`dev`, force pushes, `--no-verify` and changes to `core.hooksPath`.
- **PreToolUse (Edit/Write), `guard-files.sh`:** blocks writing secrets files (`.env`, keystores, `key.properties`) and hand-editing generated code (`*.g.dart`, l10n output).
- **PostToolUse (Edit/Write), `format-dart.sh`:** runs `dart format` on the edited Dart file when the SDK is on `PATH`.

## Git hooks (`.githooks/`, enabled by `tool/setup.sh` / `tool/setup.cmd`)

- **pre-commit:** no commits on `dev`/`main`; a gitleaks scan of staged changes (when gitleaks is installed); staged Dart files must be formatted.
- **commit-msg:** the subject must follow Conventional Commits.
- **pre-push:** no pushes to `dev`/`main`.

Never bypass hooks. If a hook is wrong, fix the hook in a `chore(hooks)` PR.
