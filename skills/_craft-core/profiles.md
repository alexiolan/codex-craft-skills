# Craft Runtime State

Workflow entrypoints persist runtime state at:

```text
.codex/craft-profile
```

Shape:

```text
host=codex
local_llm=on
routing_policy=ace
```

Use `scripts/read-runtime-state.sh` to read these values from shell scripts.

Cleanup is optional; `.codex/craft-profile` can remain as the most recent workflow profile.
