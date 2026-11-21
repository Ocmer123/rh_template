# Git workflow and environments

## Branches and environments

| Branch | Environment | Purpose | How it changes |
|---|---|---|---|
| `main` | **prod** | Released code, always green, every merge is a tagged release | PR from `dev` (release) or `hotfix/*` only, merge commit |
| `dev` | **dev** | Integration, always green, default branch | PR from a work branch, squash merge |
| `<type>/<slug>` | local | One change (`feat/login-screen`, `fix/streak-reset`) | Your commits |
| `hotfix/<slug>` | | Urgent prod fix, branched from `main` | PR into `main`, then back-merge `main` into `dev` |

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `perf`, `build`, `release`, `hotfix`.

- **Never commit or push to `dev` or `main`.** Git hooks, Claude hooks and branch protection all block it.
- Never force-push a shared branch. Never rewrite published history. Never bypass hooks (`--no-verify`).
- Work branches start from an up-to-date `dev`: `git switch dev && git pull && git switch -c feat/x`.
- Only `dev` and `hotfix/*` may target `main`; CI rejects anything else.

## What each environment means

- **dev**: every merge into `dev` runs the Dev pipeline. It reruns the full CI gate and builds a debug APK with `APP_ENV=dev`, which you can download from the run. Dev builds show a DEV banner. It is fine for testers, and never shipped to a store.
- **prod**: every merge into `main` runs the Release pipeline. It reruns CI, tags `v<version>`, builds signed release artifacts with `APP_ENV=prod` in the `production` GitHub Environment, and publishes a GitHub release. Production secrets exist only in that environment.
- Code paths that differ per environment read `AppEnv.current` (`lib/core/config/app_env.dart`). Unknown values fall back to `dev`, never to `prod`.
- No debug tools, test accounts or verbose logging in prod: guard them with `!AppEnv.current.isProd` or `kDebugMode`.

## Commits: Conventional Commits

`<type>(<scope>)!: <imperative summary>`, at most 72 characters. The `commit-msg` hook enforces it.

- Types: `feat`, `fix`, `perf`, `refactor`, `docs`, `test`, `build`, `ci`, `chore`, `revert`, `style`, `security`.
- `!` or a `BREAKING CHANGE:` footer marks a breaking change.
- One logical change per commit. Tests go in the same commit as the code they cover.
- The body explains *why*. Reference plans or issues (`Plan: 0003`, `Closes #12`).

## Pull requests

- Target `dev`. The title uses the commit format; it becomes the squash commit and the changelog line.
- Fill in `.github/pull_request_template.md`. Add a line under *Unreleased* in `CHANGELOG.md`.
- The required check is **CI gate**. Merge only when it is green and all conversations are resolved.
- Claude opens PRs but does not merge them, and does not create releases: the owner does.

## Releases (SemVer)

Version lives in `pubspec.yaml` (`version: X.Y.Z+build`). `0.x` until the first public release.

1. Run **Prepare release** (Actions) with the version. It opens `release/vX.Y.Z` into `dev`. Edit the changelog, then merge.
2. Open the PR `dev` -> `main` titled `release: vX.Y.Z`. CI checks that the version has changelog notes and its tag does not exist yet.
3. Merge with a **merge commit**. The Release pipeline tags and publishes.

Details: `.claude/skills/git-flow-release/SKILL.md` and `docs/architecture/ci-cd.md`.
