# Changelog

All notable changes to this project are documented here. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project uses [Semantic Versioning](https://semver.org/).

Add a line under *Unreleased* in every PR. `tool/release.py prepare` moves it under the new version.

## [Unreleased]

## [0.1.0] - 2026-11-21

### Added

- Flutter app skeleton with a feature-first layout and a counter reference feature covering every layer.
- `APP_ENV` dev/prod build switch, with a banner on non-production builds.
- CI gate: format, analyze, tests with a coverage gate, repo lint, branch and PR-title rules, release readiness and an Android build.
- Security checks: gitleaks, OSV-Scanner, dependency review, CodeQL and zizmor for workflows, OpenSSF Scorecard and Dependabot.
- Dev pipeline, release pipeline and a *Prepare release* workflow.
- Git hooks, Claude Code rules, agents, commands, skills and hooks.
- Docs: architecture, ADRs, plans and a generated index.
