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
4. Before broad file reads, use graph context for the files/domains in the plan when graph tools are available.
5. Implement tasks in plan order. Keep changes scoped.
6. Update `.codex/shared-state.md` during larger runs with created/modified files, verification, and open items.
7. Use local LLM scripts only when `.codex/craft-profile` has `local_llm=on` and LM Studio is available.
8. When `routing_policy=ace`, route bounded data/model/schema/mapper/parser/service/query tasks, mechanical fixes, and focused reviews to the local LLM first when the allowed file set is small and low-risk. Codex reviews the diff and owns integration.
9. Keep architecture, cross-domain integration, auth/session/server boundaries, public contracts, and final verification under Codex control.
10. Run graph review or impact checks for changed shared/high-risk files before final verification when available.
11. Run the verification commands from the plan. Do not invent missing commands.
12. For UI changes, invoke `$design-review` when `.codex/aesthetic-direction.md` exists, then `$browser-test` when browser validation is needed.
13. Invoke `$simplify` before final report for non-trivial changes.

ACE local LLM fallback rules:
- Accept local LLM implementation only after Codex inspects the diff and targeted verification passes.
- If local LLM output is empty, malformed, vague, touches files outside scope, or fails verification, switch to Codex implementation immediately.
- Use local LLM reviews to save Codex context, but do not treat them as proof.

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
