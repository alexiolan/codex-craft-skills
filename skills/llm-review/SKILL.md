---
name: llm-review
description: "Reference for running optional local LLM review scripts from Codex workflows."
---

# LLM Review

Calling skills may run local LLM scripts when `.codex/craft-profile` has `local_llm=on`.

Preferred script locations:

```text
~/.local/share/codex-craft-skills/scripts
~/.local/share/craft-skills/scripts
~/plugins/craft-skills/scripts
```

Codex remains orchestrator. Local LLM output is advisory and must be reviewed before changes are made.
