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
4. Use browser/screenshot tooling if available; otherwise perform code-level UI review.
5. Report PASS, MINOR_ISSUES, or MAJOR_ISSUES.
6. For minor issues, apply small safe fixes if the user has approved implementation work; otherwise report patches.

Write findings to:

```text
.codex/plans/{feature}/design-review.md
```
