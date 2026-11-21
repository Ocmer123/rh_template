# Security and privacy

## Secrets

- **No secrets in the repo, ever.** That includes API keys, tokens, keystores, `key.properties`, real `google-services.json` and `.env` files. Signing material lives only in the `production` GitHub Environment.
- Do not read, print or write secrets files. The Claude settings deny reading them, and `guard-files.sh` blocks writing them.
- If a secret is committed by accident, treat it as leaked: rotate it first, then remove it from history.
- Values compiled into the app with `--dart-define` are **not secret**: anyone can extract them from the APK. Only put public identifiers there.

## Checks that run automatically

| Check | Where |
|---|---|
| gitleaks secret scan | pre-commit hook (if installed) and CI |
| GitHub secret scanning and push protection | GitHub |
| OSV-Scanner on `pubspec.lock` | CI and a weekly run |
| Dependency review (vulnerabilities and licences of new dependencies) | every PR |
| CodeQL for workflows, and zizmor (workflow security) | CI |
| OpenSSF Scorecard | weekly run and on `dev` |
| Dependabot (pub and actions, 7-day cooldown) | weekly |

Never disable or weaken a check to get a PR green. Fix the cause, or document a justified exception in the PR.

## Code

- **Network:** HTTPS only, with an explicit timeout (10 s by default) and a generic User-Agent that carries no personal data. Treat every response as untrusted: validate it, parse it, never `eval` it, and never render raw HTML without sanitising it.
- **Storage:** put tokens and credentials in `flutter_secure_storage`, never in `shared_preferences` or plain files. Keep personal data on the device unless a feature explicitly needs to send it.
- **Logging:** use `Log` (`lib/core/logging/log.dart`), never `print`. Never log tokens, passwords, emails or other personal data.
- **Platform permissions:** request the minimum, at the moment they are needed, with a reason the user can see.
- **Deep links and intents:** validate every parameter before acting on it.
- **Dependencies:** prefer packages from verified publishers that are actively maintained. Justify every new dependency in the PR description (why, alternatives, licence).

## Workflows (CI)

- Pin every action to a full commit SHA with a version comment (`uses: x/y@<sha> # v1.2.3`). Dependabot keeps the pins current.
- Default `permissions: contents: read`. Grant more only on the job that needs it.
- Never put `${{ github.event.* }}` or other untrusted input straight into `run:`. Pass it through `env:`.
- Use `persist-credentials: false` on checkout unless the job pushes. Never use `pull_request_target` with a checkout of PR code.

Run the `security-reviewer` agent before every release and on any PR that touches networking, storage, auth, permissions or `.github/`.
