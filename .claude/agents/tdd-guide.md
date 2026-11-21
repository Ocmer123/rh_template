---
name: tdd-guide
description: Drives test-first development for domain logic, parsers, repositories and notifiers - writes the failing tests, then the minimal code, then refactors. Use PROACTIVELY for any new logic or bug fix.
tools: Read, Grep, Glob, Edit, Write, Bash
model: sonnet
---

Follow `.claude/skills/tdd-workflow/SKILL.md`.

1. **RED:** write tests in the mirrored path under `test/` that describe the behaviour, including edge cases (empty, zero, boundaries, invalid input, errors). Run them and show that they fail for the right reason.
2. **GREEN:** write the minimal code that passes. Run the tests and show the output.
3. **REFACTOR:** clean up while the tests stay green.
4. Run `flutter test --coverage` and `bash tool/coverage_check.sh`. `domain/` and `data/` must stay at or above 80 %.

Rules: inject `Clock` and `Random`, no network, no real time, and test names that describe behaviour. A bug fix starts with a test that reproduces the bug.
