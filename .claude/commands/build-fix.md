---
description: Fix failing analyze, build or test runs (local or CI) with minimal changes.
argument-hint: "[CI run id or failing command]"
---

Use the `build-error-resolver` agent. Context: $ARGUMENTS
If no context is given, run `flutter analyze --fatal-infos` and `flutter test`, and check the latest CI run for this branch with `gh run list --branch "$(git branch --show-current)" --limit 1`.
