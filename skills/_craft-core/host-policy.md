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

## Token economy rules

- Prefer code-review-graph summaries, semantic search, and impact/review context before broad source reads.
- When local LLM is enabled, let it read focused files and return summaries or reviews before Codex spends context on long source.
- Keep graph and LLM scopes narrow: explicit domains, routes, files, and review questions.
- Use browser screenshots/snapshots for UI evidence instead of long textual descriptions of rendered pages.
- Escalate to premium reasoning only after cheap context has narrowed the problem.

## Non-goals

- Do not hardcode vendor-specific model names into shared policy files.
- Do not define one host as the execution backend of another in this file.
