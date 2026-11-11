# Balance Robot – shared notes

Everything in `obsidian/` (Notes, Logs, Tasks, Attachments) is shared by the whole team through this repo.

**Setup (once)**
1. `git clone https://github.com/joengineer656/Graduate-Project-balance-robo.git`
2. `./link.sh "/path/to/your/vault/01 Projects"` – the folder appears in Obsidian as `Balance Robot (Shared)`.
3. In Obsidian, enable the Dataview plugin (with JavaScript queries) and the Tasks plugin.

**Use:** write notes inside `Balance Robot (Shared)`, then click **🔄 Sync with team** on its `Home` note (or run `./sync.sh`).
Sync often, so two people rarely edit the same lines.

**Notes**
- Pasted images go to your vault's attachment folder, not the shared one. Drag them into `Attachments/` so the team sees them.
- Linux/macOS/WSL only (symlink). The Home "Recently changed" table assumes you linked into `01 Projects`.
