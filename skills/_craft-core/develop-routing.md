# Develop Routing Intent

Codex is the orchestrator for all task classes.

## Task classes

| Class | Examples | Default tier | Local LLM suitability |
|---|---|---|---|
| Data layer | types, schemas, enums, mappers, services, queries | balanced | high when bounded |
| UI | components, forms, view state, route pages | balanced | medium; Codex reviews UX fit |
| Integration | routing, cross-module state, API wiring | premium | low; Codex owns integration |
| Mechanical fixes | lint/type/import sweeps | fast | high |
| Verification | focused checks, browser follow-up, diff review | fast/balanced | medium |

Rules:
- Split large ambiguous tasks before implementation.
- Keep integration under Codex control.
- Local LLM output is advisory unless reviewed by Codex.
