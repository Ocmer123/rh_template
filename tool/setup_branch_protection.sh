#!/bin/sh
# Creates dev if needed, makes it the default branch and protects dev and main
# so changes arrive only via pull requests that pass the "CI gate" check.
# Admins are included. Run once with the GitHub CLI logged in:
#
#   gh auth login
#   sh tool/setup_branch_protection.sh
#
# Branch protection is free for public repositories; private ones need GitHub Pro.
set -e

repo=$(gh repo view --json nameWithOwner -q .nameWithOwner)
echo "Configuring $repo"

if ! gh api "repos/$repo/branches/dev" >/dev/null 2>&1; then
  sha=$(gh api "repos/$repo/git/ref/heads/main" -q .object.sha)
  gh api "repos/$repo/git/refs" -f ref=refs/heads/dev -f sha="$sha" >/dev/null
  echo "Created dev from main"
fi

# Squash for feature -> dev, merge commit for dev -> main. No rebase merges.
gh api -X PATCH "repos/$repo" \
  -F allow_squash_merge=true -F allow_merge_commit=true -F allow_rebase_merge=false \
  -F allow_auto_merge=true -F delete_branch_on_merge=true \
  -f squash_merge_commit_title=PR_TITLE -f squash_merge_commit_message=PR_BODY \
  -f default_branch=dev >/dev/null
echo "Merge settings applied, default branch is dev"

# Security features (free on public repositories).
gh api -X PUT "repos/$repo/vulnerability-alerts" >/dev/null 2>&1 && echo "Dependabot alerts on" || true
gh api -X PUT "repos/$repo/automated-security-fixes" >/dev/null 2>&1 && echo "Dependabot security updates on" || true
gh api -X PATCH "repos/$repo" --input - >/dev/null 2>&1 <<'EOF' && echo "Secret scanning and push protection on" || true
{ "security_and_analysis": {
    "secret_scanning": { "status": "enabled" },
    "secret_scanning_push_protection": { "status": "enabled" } } }
EOF
gh api -X PUT "repos/$repo/private-vulnerability-reporting" >/dev/null 2>&1 && echo "Private vulnerability reporting on" || true

for branch in dev main; do
  gh api -X PUT "repos/$repo/branches/$branch/protection" --input - >/dev/null <<'EOF'
{
  "required_status_checks": { "strict": true, "contexts": ["CI gate"] },
  "enforce_admins": true,
  "required_pull_request_reviews": { "required_approving_review_count": 0, "dismiss_stale_reviews": true },
  "required_conversation_resolution": true,
  "required_linear_history": false,
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
EOF
  echo "Protected $branch"
done
echo "Done."
