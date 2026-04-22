---
name: bootstrap
description: "Loaded at session start. Establishes awareness of codex-craft-skills so Codex invokes relevant skills before acting. Not invoked directly."
---

# codex-craft-skills Bootstrap

You have access to Codex-native craft skills.

Use direct Codex skill names:
- `$craft`
- `$craft-local`
- `$craft-ace`
- `$architect`
- `$implement`
- `$finalize`
- `$develop`
- `$browser-test`
- `$debug`
- `$simplify`
- `$reflect`

## Trigger Rules

Invoke the relevant skill before taking action when the task matches:

| Skill | Trigger |
|---|---|
| `$debug` | Bug, error, failing test, unexpected behavior. Investigate before fixing. |
| `$craft` | Feature needs exploration, tradeoffs, or design approval before implementation. |
| `$implement` | Requirements are clear enough for quick plan -> develop -> test. |
| `$architect` | User wants a plan only. |
| `$develop` | Approved `.codex/plans/*.md` exists and should be executed. |
| `$finalize` | Existing approved plan should be implemented and tested. |
| `$browser-test` | Built feature needs browser validation. |
| `$simplify` | Review changed code for reuse, quality, boundaries, and verification. |
| `$reflect` | Audit or maintain `.codex/PROJECT.md`, `AGENTS.md`, plans, or installed skills. |

## Codex Context

Canonical project context:

```text
.codex/PROJECT.md
```

Generated Codex compatibility file:

```text
AGENTS.md
```

Treat `.codex/PROJECT.md` as source of truth. Regenerate `AGENTS.md` with:

```bash
bash scripts/sync-host-context.sh "$PWD"
```

Project workflow artifacts live under `.codex/`:
- `.codex/plans/`
- `.codex/prompts/`
- `.codex/reuse-index.md`
- `.codex/aesthetic-direction.md`
- `.codex/shared-state.md`

## Guardrails

- Codex is always the orchestrator.
- Do not use `/craft`; Codex skills use `$craft`.
- Do not write implementation before design/plan approval when using `$craft` or `$architect`.
- Keep changes scoped to the user request.
- Do not invent project commands; use `.codex/PROJECT.md`, package scripts, README, and config evidence.
