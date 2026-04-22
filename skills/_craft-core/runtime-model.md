# Codex Runtime Model

Codex is always the orchestrator.

## Runtime fields

### `host`

Always:

```text
codex
```

### `local_llm`

Allowed values:
- `on`
- `off`

When enabled, a local model can assist with exploration, implementation, review, or verification. Codex still owns orchestration and final judgment.

### `routing_policy`

Allowed values:
- `default`
- `ace`

`default` uses Codex as the primary executor. Local LLM, if enabled, is supplemental.

`ace` makes the local LLM the default hands for eligible bounded tasks while Codex handles architecture, fallbacks, integration, and final judgment.

### `model_tier`

Host-neutral cost/quality label:
- `premium`
- `balanced`
- `fast`

Codex maps these tiers to concrete model/runtime choices.

## Skill mapping

| Skill | Host | Local LLM | Routing policy |
|---|---|---|---|
| `craft` | `codex` | `off` | `default` |
| `craft-local` | `codex` | `on` | `default` |
| `craft-ace` | `codex` | `on` | `ace` |
