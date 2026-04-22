# Codex Model Tier Mapping

This file maps the shared tier names from `skills/_craft-core/host-policy.md` to Codex-host execution choices.

## Tier mapping

| Shared tier | Codex default use |
|---|---|
| `premium` | strongest available Codex reasoning mode for architecture, deep review, and integration |
| `balanced` | default Codex execution path for normal implementation and bounded review |
| `fast` | cheaper or narrower Codex execution mode for mechanical sweeps and lightweight verification |

## Intended usage

- `premium`: brainstorming, architecture, spec review, difficult integration reasoning
- `balanced`: standard implementation and review tasks
- `fast`: mechanical fixes, repetitive sweeps, and narrow verification

## Rule

Codex should preserve the same economic idea across models/runtimes: use expensive reasoning sparingly and intentionally.
