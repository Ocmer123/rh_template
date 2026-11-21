#!/usr/bin/env bash
# Turn the template into a new project. Run once, right after "Use this template":
#
#   bash tool/init_project.sh <package_name> <org> ["Display Name"]
#   bash tool/init_project.sh habit_garden com.example "Habit Garden"
#
# Renames the Dart package, the app title and the docs, then generates the
# android/ and ios/ platform folders with `flutter create`.
set -euo pipefail
cd "$(dirname "$0")/.."

name="${1:-}"
org="${2:-}"
display="${3:-}"
if [ -z "$name" ] || [ -z "$org" ]; then
  echo "usage: bash tool/init_project.sh <package_name> <org> [\"Display Name\"]" >&2
  exit 2
fi
if ! printf '%s' "$name" | grep -Eq '^[a-z][a-z0-9_]*$'; then
  echo "package_name must be lower_snake_case, got '$name'" >&2
  exit 2
fi
if ! printf '%s' "$org" | grep -Eq '^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$'; then
  echo "org must be a reverse domain like com.example, got '$org'" >&2
  exit 2
fi
command -v flutter >/dev/null 2>&1 || { echo "flutter is not on PATH" >&2; exit 1; }
[ -z "$display" ] && display=$(printf '%s' "$name" | sed -E 's/_/ /g; s/(^| )([a-z])/\1\u\2/g')

repo=$(git remote get-url origin 2>/dev/null | sed -E 's#(git@github.com:|https://github.com/)##; s#\.git$##' || true)

echo "Renaming rh_template -> $name ($display, $org)"
files=$(git ls-files '*.dart' '*.yaml' '*.yml' '*.md' '*.arb' '*.json' '*.py' '*.sh')
for file in $files; do
  [ "$file" = "tool/init_project.sh" ] && continue
  sed -i.bak \
    -e "s/package:rh_template\//package:$name\//g" \
    -e "s/^name: rh_template$/name: $name/" \
    -e "s/\"RH Template\"/\"$display\"/g" \
    -e "s/^# RH Template$/# $display/" \
    "$file"
  if [ -n "$repo" ]; then sed -i.bak "s#Ocmer123/rh_template#$repo#g" "$file"; fi
  rm -f "$file.bak"
done

flutter create --org "$org" --project-name "$name" --platforms=android,ios .
# flutter create adds a sample test for its own counter app; ours is already in test/.
rm -f test/widget_test.dart
flutter pub get

echo
echo "Done. Next:"
echo "  1. Review the diff (git diff) and commit on a branch: git switch -c chore/init-project"
echo "  2. Update README.md, CLAUDE.md and docs/architecture/overview.md for the new app"
echo "  3. Run: sh tool/setup_branch_protection.sh   (once, GitHub CLI logged in)"
