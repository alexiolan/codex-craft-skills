# Host Policy

This file defines Codex execution-policy intent.

## Tiered model economy

Every host adapter should preserve the same cost/quality idea:
- use expensive reasoning only where it materially improves outcomes
- use balanced execution for normal implementation and review
- use fast execution for narrow or mechanical tasks

## Tier intent

### `premium`

Use for:
- brainstorming and design exploration
- architecture planning
- spec review
- difficult integration reasoning
- ambiguous or high-risk decisions

### `balanced`

Use for:
- normal implementation tasks
- plan refinement
- code review
- bounded synthesis across a few files
- fallback execution when `fast` is too weak

### `fast`

Use for:
- mechanical fix sweeps
- narrow refactors
- lightweight verification
- repetitive transforms with clear scope

## Adapter rule

Shared workflow docs describe which tier a phase needs. Host adapters decide the concrete model, tool, or runtime that satisfies that tier.

## Non-goals

- Do not hardcode vendor-specific model names into shared policy files.
- Do not define one host as the execution backend of another in this file.
