---
description: Prepare a release from dev to main following git-flow-release.
argument-hint: <version, e.g. 0.2.0>
---

Follow `.claude/skills/git-flow-release/SKILL.md` for version $ARGUMENTS.
Run `security-reviewer` and `doc-updater` first. Stop and let the owner merge the release PR: Claude never merges into `main` or creates tags.
