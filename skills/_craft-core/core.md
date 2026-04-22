# Craft Core Pipeline

Shared Codex workflow references for the `craft` family of skills.

Codex is always the orchestrator.

## Files

- `runtime-model.md` — Codex runtime vocabulary and skill mapping
- `host-policy.md` — model-tier intent and execution-economy rules
- `project-context.md` — `.codex/PROJECT.md` contract
- `profiles.md` — `.codex/craft-profile` state
- `llm-gating.md` — local-model gating
- `develop-routing.md` — task class routing intent

## Pipeline

1. Brainstorm
2. Plan
3. Develop
4. Browser Test
5. Report

## Invariants

- Codex owns workflow control.
- `craft-local` enables local-model assistance without changing orchestration.
- `craft-ace` lets the local model act as default hands for eligible bounded tasks.
- Never skip design/plan approval before implementation in `$craft`.
- `.codex/PROJECT.md` is the primary project context.
