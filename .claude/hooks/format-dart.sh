#!/usr/bin/env bash
# PostToolUse hook (Edit|Write): format the edited Dart file when the Dart SDK
# is on PATH. Does nothing otherwise; CI still checks formatting.
input="$(cat)"
file="$(printf '%s' "$input" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]+\.dart"' | head -1 | sed -E 's/.*"([^"]+)"$/\1/' | sed 's#\\\\#/#g')"
[ -z "$file" ] && exit 0
command -v dart >/dev/null 2>&1 || exit 0
dart format "$file" >/dev/null 2>&1 || true
exit 0
