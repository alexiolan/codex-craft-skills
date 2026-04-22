---
name: reflect
description: "Audit and maintain Codex project context, plans, generated AGENTS.md, and codex-craft-skills health."
---

# Reflect

Use for project/context maintenance.

Checks:
- `.codex/PROJECT.md` matches the actual repository.
- `AGENTS.md` is generated from `.codex/PROJECT.md`.
- `.codex/plans/` is organized.
- `.codex/reuse-index.md` and `.codex/aesthetic-direction.md` are present when useful.
- Installed skills are visible in Codex as `$craft`, `$implement`, `$debug`, etc.

For context changes, update `.codex/PROJECT.md` first, then run:

```bash
bash scripts/sync-host-context.sh "$PWD"
```

Do not edit generated `AGENTS.md` directly unless specifically repairing generation output.
