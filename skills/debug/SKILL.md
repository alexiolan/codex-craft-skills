---
name: debug
description: "Use when investigating bugs, errors, failing tests, or unexpected behavior. Investigate root cause before fixing."
---

# Debug

Codex-native debugging workflow.

1. Reproduce or inspect the failure signal.
2. Read `.codex/PROJECT.md` and relevant source/config/logs.
3. Form 2-3 plausible hypotheses.
4. Test hypotheses with targeted commands or code inspection.
5. Identify root cause before editing.
6. Present the proposed fix when the change is non-trivial.
7. Implement the smallest correct fix.
8. Run targeted verification.

Do not guess. Do not make broad refactors while debugging.
