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

Then read `skills/craft/SKILL.md` from this plugin and follow the craft pipeline with the user input: `$ARGUMENTS`.

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
