---
name: simplify
description: "Review recent Codex changes for reuse, unnecessary complexity, boundary violations, and missed verification."
---

# Simplify

Review changed files before final report.

1. Inspect `git status --short` and relevant diffs.
2. Read `.codex/reuse-index.md` if present.
3. Check for duplicated helpers, premature abstractions, dead code, inconsistent naming, and import/boundary violations.
4. For UI changes, check `.codex/aesthetic-direction.md` when present.
5. Apply small safe improvements directly.
6. Escalate architectural/product tradeoffs to the user.

Run targeted verification after changes.
