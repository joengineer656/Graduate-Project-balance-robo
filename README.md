# Shared notes system

**Rule:** a note is part of the project if its frontmatter has
```
---
project: balance-robot
---
```
Keep it in whatever folder you like in your own vault. Edit only your own notes.

**Setup (once, each person)**
1. `git clone` this repo.
2. `cp notes-sync.conf.example notes-sync.conf`, set `VAULT` and `ME`.
3. Install the Dataview plugin (enable JavaScript queries). `Team/Project Index` has a "Sync notes" button that runs `./sync.sh`.

**Daily:** run `./sync.sh` (or bind it to a hotkey with the Obsidian "Shell commands" plugin).
It publishes your tagged notes to `notes/<ME>/`, pulls friends' notes, and links them in your vault under `Team/`.

**Limits:** Linux/macOS/WSL only (symlinks). Embeds are found by file name. Don't edit files under `Team/`: they are friends' notes and your edits would be overwritten.
