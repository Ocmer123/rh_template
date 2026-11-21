#!/usr/bin/env bash
# PreToolUse hook (Edit|Write): refuse to write secrets files or hand-edit
# generated code. Exit code 2 blocks the call and shows the message to Claude.
input="$(cat)"
file="$(printf '%s' "$input" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]+"' | head -1 | sed -E 's/.*"([^"]+)"$/\1/' | sed 's#\\\\#/#g')"
[ -z "$file" ] && exit 0

case "$file" in
  *.env|*.env.*|*/key.properties|*.jks|*.keystore|*.pem|*.p12|*/google-services.json|*/GoogleService-Info.plist)
    case "$file" in *.env.example) exit 0;; esac
    echo "Blocked by .claude/hooks/guard-files.sh: '$file' holds secrets. Secrets live in GitHub secrets or on the developer's machine, never written by Claude." >&2
    exit 2;;
  *.g.dart|*.freezed.dart|*/l10n/app_localizations*.dart)
    echo "Blocked by .claude/hooks/guard-files.sh: '$file' is generated. Change the source (ARB file, annotations) and regenerate." >&2
    exit 2;;
esac
exit 0
