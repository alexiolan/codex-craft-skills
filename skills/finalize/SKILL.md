---
name: finalize
description: "Use when an approved .codex plan exists and should be implemented and tested."
---

# Finalize

Input may be a plan path. If empty, find the newest plan in `.codex/plans/` excluding `archive/` and `specs/`.

If no plan exists, ask the user to run `$architect` or `$craft` first.

Then:
1. Invoke `$develop` with the plan.
2. Run verification requested by the plan.
3. Invoke `$browser-test` when relevant.
4. Report results and open items.
