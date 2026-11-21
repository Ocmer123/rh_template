---
description: Review the current branch before opening a PR (code, security, accessibility, docs).
---

1. Run the `code-reviewer` agent on `git diff dev...HEAD`.
2. If the diff touches networking, storage, auth, permissions, dependencies or `.github/`, also run `security-reviewer`.
3. If it touches `ui/` or the theme, also run `a11y-reviewer`.
4. Check that `CHANGELOG.md` *Unreleased* and the docs reflect the change (see `.claude/rules/common/documentation.md`).

Merge the findings into one list ordered by severity. Fix CRITICAL and HIGH issues before opening the PR.
