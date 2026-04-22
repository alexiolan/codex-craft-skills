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
2. Use graph-first exploration before broad file reads: minimal context, semantic search, targeted file summaries, and import/importer checks when graph tools are available.
3. When `.codex/craft-profile` has `local_llm=on`, use the local LLM for focused codebase summaries before reading many files directly.
4. Inspect only relevant source/config/docs identified by graph, LLM, or narrow `rg`.
5. Check `.codex/reuse-index.md` when the plan may add shared helpers, hooks, components, types, constants, or service primitives.
6. Ask clarifying questions one at a time when requirements are ambiguous.
7. Produce a plan with exact file paths, task order, dependencies, verification commands, acceptance criteria, and graph impact checks for risky files.
8. Include a Prior-Art Scan table for every new concept.
9. For UI work, ensure `.codex/aesthetic-direction.md` exists and invoke `$ux-brief`; for complex UI, use `ui-ux-pro-max` through the UX brief when available.

Save approved plans to:

```text
.codex/plans/YYYY-MM-DD-{feature}.md
```

After saving, report the path and say it is ready for `$develop` or `$finalize`.
