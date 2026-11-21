#!/usr/bin/env bash
# Usage: tool/coverage_check.sh [coverage/lcov.info] [min-percent]
# Fails when line coverage of lib/features/*/domain and lib/features/*/data is
# below the threshold. UI is covered by widget tests but not gated.
set -euo pipefail
lcov="${1:-coverage/lcov.info}"
min="${2:-80}"

if [ ! -f "$lcov" ]; then
  echo "::error::No coverage file at $lcov. Run: flutter test --coverage"
  exit 1
fi

awk -v min="$min" '
  /^SF:/ {
    file = substr($0, 4); gsub(/\\/, "/", file)
    track = (file ~ /lib\/features\/[^\/]+\/(domain|data)\// && file !~ /\.(g|freezed)\.dart$/)
  }
  /^LF:/ { if (track) total += substr($0, 4) }
  /^LH:/ { if (track) hit += substr($0, 4) }
  END {
    if (total == 0) { print "No domain/data files covered yet, skipping."; exit 0 }
    pct = hit * 100 / total
    printf "domain+data line coverage: %.1f%% (%d/%d), required %d%%\n", pct, hit, total, min
    if (pct < min) { print "::error::coverage below " min "%"; exit 1 }
  }
' "$lcov"
