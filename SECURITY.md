# Security policy

## Supported versions

Only the latest release on `main` gets security fixes.

## Reporting a vulnerability

Please **do not open a public issue**. Report it privately through [GitHub security advisories](https://github.com/Ocmer123/rh_template/security/advisories/new) instead.

Include what you found, how to reproduce it, and the impact you expect. You will get a reply within 7 days. A fix ships as a `hotfix/*` release as soon as it is ready, and you will be credited unless you prefer not to be.

## How this repository protects itself

- Secret scanning with push protection, plus a gitleaks scan on every PR and (optionally) before every commit.
- OSV-Scanner and GitHub dependency review on every PR, a weekly scan, and Dependabot updates with a 7-day cooldown.
- CodeQL and zizmor analysis of the GitHub Actions workflows. All actions are pinned to commit SHAs with least-privilege tokens.
- Branch protection on `dev` and `main`: pull requests only, with the CI gate required. Admins are included.
- Production signing secrets exist only in the `production` GitHub Environment, which only the release pipeline on `main` uses.

The contributor rules are in [.claude/rules/common/security.md](.claude/rules/common/security.md).
