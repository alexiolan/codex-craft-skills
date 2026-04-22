---
name: ux-brief
description: "Generate a Codex UI brief for a planned feature, using .codex/aesthetic-direction.md when present."
---

# UX Brief

Generate a concise UX implementation brief for UI work.

Input should be a spec or plan path. If empty, ask for one.

Process:
1. Read the spec/plan.
2. Read `.codex/aesthetic-direction.md` if present.
3. Inspect affected or analogous UI files.
4. Write a brief with layout intent, component reuse, copy/state requirements, accessibility checks, and visual success criteria.

Write to:

```text
.codex/plans/{feature}/ux-brief.md
```

If no feature directory exists, write beside the plan with a clear filename.
