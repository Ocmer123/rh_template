#!/usr/bin/env bash
# PreToolUse hook (Bash): block pushes to main/dev, force pushes, hook bypasses
# and switching the git hooks off. Exit code 2 blocks the call and shows the
# message to Claude.
input="$(cat)"

block() {
  echo "Blocked by .claude/hooks/guard-git.sh: $1" >&2
  exit 2
}

if printf '%s' "$input" | grep -Eq 'git[^"]*[[:space:]]push[^"]*([[:space:]](main|dev)([^[:alnum:]_/.-]|$)|:(main|dev)([^[:alnum:]_/.-]|$))'; then
  block "never push to main or dev. Push a feature branch and open a PR into dev."
fi
if printf '%s' "$input" | grep -Eq 'git[^"]*[[:space:]]push[^"]*([[:space:]]--force|[[:space:]]-f([[:space:]]|$|")|[[:space:]]\+[^[:space:]]+)'; then
  block "no force pushes. Add a new commit instead."
fi
if printf '%s' "$input" | grep -Eq -- '--no-verify|core\.hooksPath'; then
  block "do not bypass or change the git hooks. If a hook is wrong, fix it in a chore(hooks) PR."
fi
exit 0
