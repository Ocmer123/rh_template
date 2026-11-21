---
description: Start a feature end to end - branch, plan, TDD, verify, review, PR into dev.
argument-hint: <feature name and goal>
---

Feature: $ARGUMENTS

1. `git switch dev && git pull`, then `git switch -c feat/<slug>`.
2. `/plan` it and wait for the owner's approval.
3. Scaffold the folders with `.claude/skills/new-feature/SKILL.md`.
4. For each plan step: `/tdd` for the logic, `flutter-ui-engineer` for screens, and one Conventional Commit per step.
5. `/verify`, then `/review`, then fix what they find.
6. Add the *Unreleased* line to `CHANGELOG.md`, push, and run `gh pr create --base dev --fill` with the PR template filled in.
7. Report the PR link and the CI status. Do not merge.
