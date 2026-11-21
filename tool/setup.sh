#!/bin/sh
# One-time local setup after cloning: enable the shared git hooks and fetch packages.
set -e
cd "$(dirname "$0")/.."
git config core.hooksPath .githooks
chmod +x .githooks/* tool/*.sh .claude/hooks/*.sh 2>/dev/null || true
echo "Git hooks enabled: no direct commits to dev/main, Conventional Commit messages, secret scan."
if command -v flutter >/dev/null 2>&1; then
  flutter pub get
else
  echo "Flutter is not on PATH; run 'flutter pub get' yourself."
fi
command -v gitleaks >/dev/null 2>&1 || echo "Tip: install gitleaks so the pre-commit hook can scan for secrets locally (CI always does)."
