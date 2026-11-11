#!/usr/bin/env bash
# Commit my changes to the shared folder, pull friends' changes, push.
set -euo pipefail
cd "$(dirname "$0")"
git add -A
git diff --cached --quiet || git commit -qm "sync: $(git config user.name) $(date '+%F %R')"
git pull --rebase --autostash -q || { echo "Conflict: two people edited the same lines. Run 'git status' in the repo to fix."; exit 1; }
git push -q
echo "Synced $(date '+%R')"
