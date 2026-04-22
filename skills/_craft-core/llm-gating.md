# LLM Gating Rules

Local LLM (LM Studio) paths run only when runtime state sets `local_llm=on`.

## Localhost sandbox check

Before treating LM Studio as unavailable, check `${LLM_URL:-http://127.0.0.1:1234}/v1/models`.
If the sandbox returns `Operation not permitted` or curl exit `7`, retry the same localhost check
with `sandbox_permissions: "require_escalated"`. If models are returned, use the local LLM; the
failure was sandbox access, not LM Studio availability.

## Gated step: `architect` pre-exploration (Step 0)

Currently `architect/SKILL.md` runs an LLM availability check and optional background exploration via `llm-agent.sh`. Under profile gating:

```bash
eval "$(bash "$CRAFT_SCRIPTS/read-runtime-state.sh" "$PROJECT_ROOT")"
if [[ "$LLM_ENABLED" = "1" ]]; then
  # existing LLM availability check + background llm-agent.sh dispatch
else
  echo "LLM_SKIPPED_BY_RUNTIME"
fi
```

## Gated step: `develop` Step 3.5 (post-develop review)

Currently runs `llm-agent.sh` to review implementation files. Same gating pattern.

## Gated step: `craft` spec review (Step 1.10)

Currently runs `llm-review.sh` as a parallel supplementary review of the spec. Same gating pattern.

## Gated step: `craft` plan review (Step 2.4)

Currently runs `llm-review.sh` as a parallel supplementary review of the plan. Same gating pattern.

## Unloading

LM Studio keep-loaded / unload scripts run only when LLM was actually loaded. The guard is the same runtime-state check — if LLM was skipped, don't call `llm-unload.sh`.

## What does NOT get gated

Graph tools (`code-review-graph` MCP) run in every profile. They are deterministic infrastructure, not AI. See `profiles.md`.
