@echo off
rem One-time local setup after cloning (cmd / PowerShell): enable the shared git hooks.
cd /d "%~dp0.."
git config core.hooksPath .githooks
echo Git hooks enabled: no direct commits to dev/main, Conventional Commit messages, secret scan.
where flutter >nul 2>nul && flutter pub get || echo Flutter is not on PATH; run "flutter pub get" yourself.
where gitleaks >nul 2>nul || echo Tip: install gitleaks so the pre-commit hook can scan for secrets locally (CI always does).
