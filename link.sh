#!/usr/bin/env bash
# One-time: show the shared folder inside your vault.  Usage: ./link.sh "/path/to/vault/01 Projects"
set -euo pipefail
[ -d "${1:-}" ] || { echo "Usage: ./link.sh \"/path/to/folder/inside/your/vault\""; exit 1; }
ln -sn "$(cd "$(dirname "$0")" && pwd)/obsidian" "$1/Balance Robot (Shared)"
echo "Linked: $1/Balance Robot (Shared)"
