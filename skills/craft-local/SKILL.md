---
name: craft-local
description: "Codex craft pipeline with LM Studio/local LLM assistance enabled. Codex remains orchestrator."
---

# Craft Local

Use the same pipeline as `$craft`, but enable local LLM assistance for token-efficient exploration and review. Codex remains the implementation owner under the default routing policy.

First action:

```bash
mkdir -p .codex
cat > .codex/craft-profile <<EOF
host=codex
local_llm=on
routing_policy=default
EOF
```

Then read `skills/craft/SKILL.md` from this plugin and follow the craft pipeline with the user input: `$ARGUMENTS`. Do not overwrite `.codex/craft-profile` when entering `$craft`; this wrapper already set `local_llm=on`.

Local model requirements:
- LM Studio running at `${LLM_URL:-http://127.0.0.1:1234}`
- Optional `LLM_MODEL` override

Localhost sandbox note:
- Before treating the local LLM as unavailable, check `${LLM_URL:-http://127.0.0.1:1234}/v1/models`.
- If the sandbox returns `Operation not permitted` or curl exit `7`, retry the same localhost check with `sandbox_permissions: "require_escalated"`.
- If models are returned, use the local LLM for craft-local exploration and review tasks; the failure was sandbox access, not LM Studio availability.

Craft-local intent:
- Use graph-first and local-LLM summaries before broad source reads.
- Run local LLM review for spec, plan, and post-develop changed files when useful.
- Do not make local LLM the default implementer; that is `$craft-ace`.

Codex owns brainstorming, planning, implementation, integration, verification, and final judgment.
