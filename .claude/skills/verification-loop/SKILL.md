---
name: verification-loop
description: The definition-of-done check to run before every commit or PR - format, codegen, analyze, test with coverage, docs index, self-review. Use when finishing a task or when asked to verify.
---

# Verification loop

Run the commands in order. Stop and fix at the first failure.

```bash
flutter pub get
# only if build_runner is a dependency:
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos
flutter test --coverage
bash tool/coverage_check.sh coverage/lcov.info 80
python tool/docs_index.py --check
```

Then:

1. **Acceptance:** reread the plan's acceptance criteria in `docs/plans/` and tick each one you met.
2. **Self-review:** go through the `code-reviewer` checklist on `git diff dev...HEAD`.
3. **Docs:** `CHANGELOG.md` *Unreleased* is updated, plus an ADR or architecture doc where needed.
4. **Environments:** nothing debug-only can reach a prod build (`AppEnv`, `kDebugMode`).

**No local Flutter SDK?** Say so explicitly, push the branch, and check CI:
`gh run list --branch <branch> --limit 1`, then `gh run view <id> --log-failed`.

Never claim that something passes without output that shows it.
