# Balance Robot – Project Index
(Needs the Dataview plugin, with JavaScript queries enabled.)

```dataviewjs
const b = dv.el("button", "🔄 Sync notes");
b.onclick = () => {
  b.disabled = true; b.textContent = "Syncing...";
  require("child_process").execFile("bash", ["__REPO__/sync.sh"], (e, out, err) => {
    b.disabled = false;
    b.textContent = e ? "❌ " + (err || e.message).slice(-200) : "✅ " + out.trim();
  });
};
```

```dataview
TABLE file.folder AS Where, file.mtime AS Updated
WHERE project = "balance-robot" AND file.name != "Project Index"
SORT file.mtime DESC
```
