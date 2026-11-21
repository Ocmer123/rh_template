# 0002 Work branches, dev, main and PR-only merges

Status: Accepted
Date: 2026-11-21

## Context

Every change should be tested automatically and reviewable, and nothing should land on the shared branches without passing the same checks, including changes made by Claude.

## Decision

Work happens on `<type>/<slug>` branches that are squash-merged into `dev`. `dev` is released into `main` with a merge commit. Both branches are protected and require the single **CI gate** check (admins included). Git hooks and Claude Code hooks also block direct commits and pushes. PR titles and commits follow Conventional Commits, which feed the changelog. Details are in [CI/CD](../architecture/ci-cd.md).

## Alternatives considered

- **Trunk-based (only `main`):** faster, but it gives no integration stage before production.
- **Full git flow with release branches:** more ceremony than a small team needs; *Prepare release* covers the useful part.
- **Several required checks instead of one gate:** brittle when jobs are added or renamed. One gate job that depends on all the others is easier to maintain.

## Consequences

Changes are slower than committing directly, but every change is checked. A solo owner cannot approve their own PR, so the required approvals are 0 and the CI gate is the guard. Bot-created PRs need a PAT to trigger CI.
