---
name: browser-test
description: "Use after implementation when Codex needs browser-based validation of UI or browser-observable behavior."
---

# Browser Test

Use browser automation when available. If no browser tooling is available, provide a manual test checklist instead.

Input may be a spec or plan path. If empty, auto-detect the newest relevant file from:

```text
.codex/plans/specs/
.codex/plans/
```

Process:
1. Read `.codex/PROJECT.md` and the spec/plan.
2. Identify affected routes and user flows.
3. Determine how to start the app from documented commands only.
4. Test desktop and mobile states when the UI is responsive.
5. Capture failures with route, viewport, reproduction steps, and likely owner file.
6. Write findings to `.codex/plans/{feature}/browser-test.md` when a feature directory exists.

Do not make implementation fixes inside browser-test unless the user explicitly asks.
