#!/usr/bin/env bash
# Publish my tagged notes to the repo, pull friends' notes, link them into my vault.
# Usage: ./sync.sh        (config in notes-sync.conf)
set -euo pipefail
cd "$(dirname "$0")"
[ -f notes-sync.conf ] || { echo "Missing notes-sync.conf (copy notes-sync.conf.example)"; exit 1; }
source notes-sync.conf   # VAULT=/path/to/my/vault  ME=myname
[ -d "$VAULT" ] && [ -n "${ME:-}" ] || { echo "Bad VAULT or ME in notes-sync.conf"; exit 1; }
TAG='^project:.*balance-robot'
OUT="notes/$ME"

# 1. Publish: mirror my tagged notes (skip Team/ links and .obsidian) so untagged/deleted notes disappear.
rm -rf "$OUT"; mkdir -p "$OUT/_attachments"
while IFS= read -r f; do
  rel="${f#"$VAULT"/}"
  mkdir -p "$OUT/$(dirname "$rel")"; cp "$f" "$OUT/$rel"
  # copy embedded files: ![[name.png]] and ![](path/name.png); resolved by file name (Obsidian shortest-path style)
  { { grep -oE '!\[\[[^]|#]+' "$f" || true; } | sed 's/^!\[\[//'
    { grep -oE '!\[[^]]*\]\([^)]+\)' "$f" || true; } | sed -E 's/.*\(([^)]+)\)/\1/; s/%20/ /g'; } |
  while IFS= read -r a; do
    case "$a" in *.md|http*) continue;; esac
    src=$(find "$VAULT" -path "$VAULT/Team" -prune -o -path "$VAULT/.obsidian" -prune -o -type f -name "$(basename "$a")" -print -quit)
    [ -n "$src" ] && cp -n "$src" "$OUT/_attachments/" || true
  done
done < <(grep -rlE --include='*.md' "$TAG" "$VAULT" --exclude-dir=Team --exclude-dir=.obsidian || true)

# 2. Git: commit mine, pull theirs, push.
git add -A "$OUT"
git diff --cached --quiet || git commit -qm "notes: update $ME"
git pull --rebase --autostash -q || echo "(pull skipped: no remote yet?)"
git push -q || echo "(push skipped: no remote yet?)"

# 3. Link everyone else's notes into the vault as Team/<person> (read-only by convention).
mkdir -p "$VAULT/Team"
find "$VAULT/Team" -maxdepth 1 -type l -delete
for d in "$PWD"/notes/*/; do
  p=$(basename "$d"); [ "$p" = "$ME" ] || ln -s "${d%/}" "$VAULT/Team/$p"
done
if [ ! -f "$VAULT/Team/Project Index.md" ]; then  # __REPO__ = where the sync button finds this script
  shopt -u patsub_replacement 2>/dev/null || true; t=$(<INDEX.template.md); printf '%s\n' "${t//__REPO__/$PWD}" > "$VAULT/Team/Project Index.md"
fi
echo "Done: published $(find "$OUT" -name '*.md' | wc -l) notes."
