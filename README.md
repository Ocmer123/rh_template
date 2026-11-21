# RH Template

[![CI](https://github.com/Ocmer123/rh_template/actions/workflows/dev.yml/badge.svg?branch=dev)](https://github.com/Ocmer123/rh_template/actions/workflows/dev.yml)
[![Security](https://github.com/Ocmer123/rh_template/actions/workflows/security.yml/badge.svg)](https://github.com/Ocmer123/rh_template/actions/workflows/security.yml)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/Ocmer123/rh_template/badge)](https://scorecard.dev/viewer/?uri=github.com/Ocmer123/rh_template)

A Flutter app template with everything a new project needs from day one:

- **Git flow with two environments:** work branches -> `dev` (dev environment) -> `main` (prod). Direct pushes are blocked by git hooks, Claude Code hooks and branch protection.
- **CI gate on every PR:** formatting, `flutter analyze --fatal-infos`, tests with an 80 % coverage gate on domain and data, Markdown, link, shell and workflow linting, branch and PR-title rules, and an Android build.
- **Security checks:** gitleaks, OSV-Scanner, dependency review (vulnerabilities and licences), CodeQL and zizmor for workflows, OpenSSF Scorecard, Dependabot with a cooldown, and every action pinned to a commit SHA.
- **Pipelines:** a dev pipeline (debug APK per merge into `dev`), a release pipeline (tag, `APP_ENV=prod` build and GitHub release per merge into `main`), and a one-click *Prepare release*.
- **Claude Code setup:** rules, agents, commands, skills and safety hooks in [`.claude/`](.claude/), summarised in [CLAUDE.md](CLAUDE.md).
- **Docs:** architecture, ADRs, plans, a changelog and a generated docs index in [docs/](docs/README.md).

## Start a new project from this template

1. On GitHub, click **Use this template** > *Create a new repository*, then clone it.
2. Rename the app and generate the platform folders:

   ```bash
   bash tool/init_project.sh my_app com.example "My App"
   ```

3. Enable the git hooks: `sh tool/setup.sh` (or `tool\setup.cmd` on Windows).
4. Commit on a branch (`git switch -c chore/init-project`), push `main`, then protect the branches:

   ```bash
   sh tool/setup_branch_protection.sh   # creates dev, makes it the default branch, protects dev and main
   ```

5. Replace the placeholder text in `README.md`, `CLAUDE.md` and `docs/architecture/overview.md`.

## Everyday commands

```bash
flutter pub get
flutter run --dart-define=APP_ENV=dev
dart format .
flutter analyze --fatal-infos
flutter test --coverage && bash tool/coverage_check.sh
python tool/docs_index.py
```

## Learn more

- [CONTRIBUTING.md](CONTRIBUTING.md): branching, commits, PRs and releases
- [CI/CD and environments](docs/architecture/ci-cd.md)
- [Architecture overview](docs/architecture/overview.md)
- [Security policy](SECURITY.md)
- [Changelog](CHANGELOG.md)
