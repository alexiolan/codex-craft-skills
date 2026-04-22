---
name: develop
description: "Use when an approved .codex implementation plan is ready to execute. Codex implements, verifies, reviews, and reports."
---

# Develop

Execute an approved plan with Codex as orchestrator.

## Input

- Plan path: use that plan.
- Empty input: auto-detect the newest `.md` file in `.codex/plans/` excluding `archive/` and `specs/`.

If no plan is found, ask the user to run `$architect` or `$craft`.

## Process

1. Read `.codex/PROJECT.md`, `AGENTS.md`, and the plan.
2. Confirm the plan is approved. If approval is unclear, ask before editing.
3. Check current git status and avoid touching unrelated user changes.
4. Implement tasks in plan order. Keep changes scoped.
5. Update `.codex/shared-state.md` during larger runs with created/modified files, verification, and open items.
6. Use local LLM scripts only when `.codex/craft-profile` has `local_llm=on` and LM Studio is available.
7. Run the verification commands from the plan. Do not invent missing commands.
8. For UI changes, invoke `$design-review` when `.codex/aesthetic-direction.md` exists, then `$browser-test` when browser validation is needed.
9. Invoke `$simplify` before final report for non-trivial changes.

Only use sub-agents when the active Codex environment supports them and the user has explicitly allowed delegation/parallel agent work.

## Local LLM Script Lookup

When scripts are needed, prefer the plugin path provided by Codex. If unavailable, look in:

```text
~/.local/share/codex-craft-skills/scripts
~/.local/share/craft-skills/scripts
~/plugins/craft-skills/scripts
```

## Report

Report:
- files changed
- verification run
- skipped verification with reason
- design/browser test result when relevant
- open items
