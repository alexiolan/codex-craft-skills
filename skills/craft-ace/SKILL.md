---
name: craft-ace
description: "Codex craft pipeline where the local LLM is default hands for eligible bounded tasks while Codex remains orchestrator."
---

# Craft ACE

Use the same pipeline as `$craft`, but route eligible bounded work to the local LLM by default when available.

First action:

```bash
mkdir -p .codex
cat > .codex/craft-profile <<EOF
host=codex
local_llm=on
routing_policy=ace
EOF
```

Then read `skills/craft/SKILL.md` from this plugin and follow the craft pipeline with the user input: `$ARGUMENTS`. Do not overwrite `.codex/craft-profile` when entering `$craft`; this wrapper already set `local_llm=on` and `routing_policy=ace`.

Codex remains responsible for:
- architecture
- task boundaries
- integration
- fallbacks
- verification
- final quality judgment

Local model requirements:
- LM Studio running at `${LLM_URL:-http://127.0.0.1:1234}`
- Optional `LLM_MODEL` override

Localhost sandbox note:
- Before treating the local LLM as unavailable, check `${LLM_URL:-http://127.0.0.1:1234}/v1/models`.
- If the sandbox returns `Operation not permitted` or curl exit `7`, retry the same localhost check with `sandbox_permissions: "require_escalated"`.
- If models are returned, use the local LLM for bounded ACE tasks; the failure was sandbox access, not LM Studio availability.

ACE routing intent:
- Use graph-first and local-LLM summaries before broad source reads to preserve Codex context.
- Prefer local LLM for bounded data/model/schema/mapper/parser/service/query tasks, mechanical fixes, and focused reviews.
- Use local LLM review loops for spec and plan when useful.
- Keep architecture, cross-domain integration, auth/session/server boundaries, final UX judgment, browser testing, and verification under Codex control.
- If local LLM output is empty, vague, risky, or fails verification, Codex takes over immediately.
