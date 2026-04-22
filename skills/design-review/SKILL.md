---
name: design-review
description: "Review Codex UI changes against .codex/aesthetic-direction.md and the feature UX brief when available."
---

# Design Review

Run after implementation when UI files changed.

Skip if `.codex/aesthetic-direction.md` is missing unless the user explicitly asks for best-effort review.

Process:
1. Read `.codex/aesthetic-direction.md`.
2. Read the feature spec/plan and `ux-brief.md` if present.
3. Identify affected routes/components from git diff or `.codex/shared-state.md`.
4. Use browser/screenshot tooling when available. Capture at least desktop and mobile for responsive UI, plus key interaction states named in the UX brief.
5. Use `ui-ux-pro-max` when available for complex UI or data-dense workflows; otherwise perform a code-level UI review and record the degraded gate.
6. Report PASS, MINOR_ISSUES, or MAJOR_ISSUES.
7. For minor issues, apply small safe fixes if the user has approved implementation work; otherwise report patches.

Write findings to:

```text
.codex/plans/{feature}/design-review.md
```
