---
name: reuse-index
description: "Generate or refresh .codex/reuse-index.md, a concise inventory of reusable project primitives that Codex should consult before creating new helpers/types/components."
---

# Reuse Index

Generate `.codex/reuse-index.md`.

## Input

- Empty: auto-detect shared directories.
- Path: scan that path.
- `--force`: regenerate even if the file exists.

## Process

1. Create `.codex/` if missing.
2. Detect shared surfaces in common locations: `src/shared`, `src/domain/shared`, `src/common`, `src/lib`, `src/utils`, `packages/shared`, `packages/ui`.
3. If no shared directory is found, ask the user for a path or write a stub that explains how to fill the file manually.
4. Scan exported symbols and group them by category: UI primitives, hooks, utilities, enums/labels, services/HTTP, query factories, forms, notifications/errors, types/models.
5. Keep the file concise; prefer useful entries over exhaustive listings.
6. Include a "What NOT to duplicate" section for known reusable patterns.

Write:

```text
.codex/reuse-index.md
```

Downstream skills must consult it before introducing new shared helpers, hooks, components, types, constants, or service primitives.
