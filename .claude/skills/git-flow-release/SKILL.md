---
name: git-flow-release
description: Branching, PR, release and hotfix procedure (work branch -> dev -> main, SemVer, CHANGELOG, tags by the Release pipeline). Use when starting a branch, opening a PR, cutting a release or shipping a hotfix.
---

# Git flow and release

## Work branch -> dev

```bash
git switch dev && git pull
git switch -c feat/login-screen
# ... Conventional Commits ...
git push -u origin feat/login-screen
gh pr create --base dev --fill
gh pr checks --watch
```

The owner squash-merges once **CI gate** is green. The branch is deleted automatically. The Dev pipeline then builds a dev APK.

## Release dev -> main

1. Actions > **Prepare release** > the version (for example `0.2.0`). Or locally, on a branch from `dev`: `python tool/release.py prepare 0.2.0`.
2. Review the `chore(release): prepare v0.2.0` PR into `dev`. Make the changelog readable for users, then merge it.
3. `gh pr create --base main --head dev --title "release: v0.2.0" --body "See CHANGELOG.md"`.
4. CI checks that `CHANGELOG.md` has a `## [0.2.0]` section and that tag `v0.2.0` does not exist yet.
5. The owner merges with a **merge commit** (not a squash, so `dev` and `main` share history).
6. The Release pipeline reruns CI, tags `v0.2.0`, builds `APP_ENV=prod` artifacts in the `production` environment, and publishes the GitHub release.

## Hotfix

```bash
git switch main && git pull
git switch -c hotfix/crash-on-start
# fix, with a test that reproduces the bug; bump the patch version and add a changelog section
gh pr create --base main --title "fix: crash on start"
```

After the merge, open a PR `main` -> `dev` so that `dev` gets the fix too.

## Version numbers

`pubspec.yaml` `version: MAJOR.MINOR.PATCH+BUILD`. Bump MINOR for features, PATCH for fixes, and MAJOR for breaking changes (after 1.0). BUILD always goes up by one; `tool/release.py prepare` does that for you.
