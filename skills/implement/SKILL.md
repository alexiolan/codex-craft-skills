---
name: implement
description: "Use for a clear Codex feature request that can go through quick planning, implementation, and browser testing."
---

# Implement

Fast path for clear requirements.

1. Invoke `$architect` with the requirements.
2. Wait for user approval of the plan.
3. Invoke `$develop` with the approved plan path.
4. Invoke `$browser-test` when the change has UI or browser-observable behavior.
5. Report files changed, verification, and open items.

If requirements become ambiguous, switch to `$craft` for deeper brainstorm.
