---
name: aesthetic-direction
description: "Generate or verify .codex/aesthetic-direction.md, the project design-language contract for Codex UI planning and review."
---

# Aesthetic Direction

Generate `.codex/aesthetic-direction.md` once per project when UI work is planned.

## Process

1. Create `.codex/` if missing.
2. Read `.codex/PROJECT.md`, existing UI/theme files, global CSS, Tailwind/DaisyUI config, and representative shared UI components.
3. Describe the existing visual language. Do not invent a redesign.
4. Capture:
   - one-sentence visual north star
   - typography
   - color tokens
   - density/spacing/radius
   - component shape and interaction patterns
   - accessibility baseline
   - what the project explicitly should not use
5. Write the result to `.codex/aesthetic-direction.md`.

If an external frontend-design skill is available in Codex, it may be used as input, but Codex remains responsible for final judgment and the file write.

Downstream skills read this file for `$ux-brief`, `$design-review`, and `$simplify`.
