# Balance Robot – Shared

```dataviewjs
// The button finds sync.sh through this note's real location, so it works for everyone.
const path = require("path"), fs = require("fs");
const repo = path.dirname(path.dirname(fs.realpathSync(app.vault.adapter.basePath + "/" + dv.current().file.path)));
const b = dv.el("button", "🔄 Sync with team");
b.onclick = () => {
  b.disabled = true; b.textContent = "Syncing...";
  require("child_process").execFile("bash", [repo + "/sync.sh"], (e, out, err) => {
    b.disabled = false;
    b.textContent = e ? "❌ " + (out + err).trim().slice(-200) : "✅ " + out.trim();
  });
};
```

## Open tasks
```tasks
not done
path includes Balance Robot (Shared)
```

## Recently changed
```dataview
TABLE file.folder AS Folder, file.mtime AS Changed
FROM "01 Projects/Balance Robot (Shared)"
SORT file.mtime DESC
LIMIT 15
```
