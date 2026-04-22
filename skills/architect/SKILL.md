---
name: architect
description: "Use when the user needs a Codex-native implementation plan before coding. No implementation is written."
---

# Architect

Create a detailed implementation plan. Do not write implementation code.

## Input

The user input is: `$ARGUMENTS`

Input handling:
- Prompt number: read `.codex/prompts/{number}*.md`.
- Direct prompt text: use it as requirements.
- Empty input: ask for a prompt number or requirements.

## Process

1. Read `.codex/PROJECT.md` and `AGENTS.md` if present.
2. Inspect only relevant source/config/docs.
3. Check `.codex/reuse-index.md` when the plan may add shared helpers, hooks, components, types, constants, or service primitives.
4. Ask clarifying questions one at a time when requirements are ambiguous.
5. Produce a plan with exact file paths, task order, dependencies, verification commands, and acceptance criteria.
6. Include a Prior-Art Scan table for every new concept.
7. For UI work, ensure `.codex/aesthetic-direction.md` exists or explicitly note that the UI design contract is missing.

Save approved plans to:

```text
.codex/plans/YYYY-MM-DD-{feature}.md
```

After saving, report the path and say it is ready for `$develop` or `$finalize`.
