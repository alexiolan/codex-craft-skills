---
name: craft
description: "Use when starting a new Codex feature workflow that needs design exploration before implementation. Runs Brainstorm -> Plan -> Develop -> Browser Test -> Report with Codex as orchestrator."
---

# Craft

Codex-native design-first development pipeline.

**Pipeline:** Brainstorm -> Plan -> Develop -> Browser Test -> Report

<HARD-GATE>
Do not write implementation code, scaffold files, or take implementation actions until you have presented a design and the user has approved it.
</HARD-GATE>

## Input

The user input is: `$ARGUMENTS`

Input handling:
- Prompt number: read `.codex/prompts/{number}*.md`.
- Direct prompt text: use it as the feature description.
- Empty input: ask for a prompt number or requirements.

## Runtime State

For direct `$craft` invocation, first action:

```bash
mkdir -p .codex
cat > .codex/craft-profile <<EOF
host=codex
local_llm=off
routing_policy=default
EOF
```

If this pipeline is being followed from `$craft-local` or `$craft-ace`, do not overwrite `.codex/craft-profile`; the wrapper already set the intended runtime state.

## Phase 1: Brainstorm

1. Read `.codex/PROJECT.md` and root `AGENTS.md` if present.
2. Check recent git context with `git log --oneline -10`.
3. Do graph-first exploration before broad source reads:
   - `get_minimal_context_tool` for a compact starting point when available.
   - `build_or_update_graph_tool` if the graph is stale or missing.
   - `semantic_search_nodes_tool` with 2-3 feature keywords.
   - `query_graph_tool` with `file_summary`, `imports_of`, or `importers_of` for only the most relevant files/domains.
4. When `.codex/craft-profile` has `local_llm=on`, use the local LLM early for token economy: ask it to inspect 2-3 focused paths and return a summary instead of pulling large files into Codex context. Codex still triages and verifies.
5. Inspect only the relevant source/config/docs that graph or LLM summaries identify.
6. Ask clarifying questions one at a time.
7. Propose 2-3 approaches with trade-offs and lead with a recommendation.
8. Present the selected design and wait for user approval.

Token economy rules:
- Prefer graph summaries, semantic search, and LLM file-reading summaries before loading long files directly.
- Never ask graph tools or LLM helpers to explore the whole repo; scope to explicit domains, routes, or files.
- Avoid graph tools known to emit huge payloads unless the user explicitly needs them: architecture overviews, full community listings, and broad change detection.
- When the local LLM returns empty/thinking-only output, retry once with a shorter prompt; then fall back to graph plus direct file reads.

## Phase 2: Spec

Before writing the spec, ensure the Codex project folders exist:

```bash
mkdir -p .codex/plans/specs .codex/plans/archive .codex/prompts
```

If `.codex/reuse-index.md` is missing and the feature may introduce shared utilities, hooks, components, types, constants, or helpers, invoke `$reuse-index` or explain that the reuse gate is skipped.

For UI work:
- If `.codex/aesthetic-direction.md` is missing, invoke `$aesthetic-direction` or explain that the design contract is skipped.
- Invoke `$ux-brief` after the spec exists. For complex UI, the brief should use `ui-ux-pro-max` when available; if unavailable, record the degraded design gate in the spec.
- Fold UX brief success criteria and hard layout/a11y constraints back into the spec before planning.

Write the approved design to:

```text
.codex/plans/specs/YYYY-MM-DD-{feature}-design.md
```

The spec must include a Prior-Art Scan table for every new concept it introduces. Cite `.codex/reuse-index.md` when present.

Review the spec for placeholders, contradictions, ambiguity, and scope creep.

When `local_llm=on`, run a focused local LLM review of the spec for completeness, API alignment, security/safety, and reuse duplication. In `routing_policy=ace`, prefer a local review loop over Codex-only self-review: fix confirmed findings and rerun until one clean pass or diminishing returns. Present the spec path and wait for user approval before planning implementation.

## Phase 3: Plan

Create an implementation plan with:
- exact file paths
- task ordering
- parallel/sequential dependencies
- verification commands
- acceptance criteria
- rollback or risk notes when relevant
- graph impact checks for shared/high-risk files when applicable
- explicit local LLM routing notes when `routing_policy=ace`

Save the approved plan to:

```text
.codex/plans/YYYY-MM-DD-{feature}.md
```

When `local_llm=on`, run a focused local LLM review of the plan for spec coverage, task ordering, risk, security/safety, and reuse duplication. In `routing_policy=ace`, fix confirmed findings and rerun once when useful. Wait for user approval before developing.

## Phase 4: Develop

Invoke `$develop` with the approved plan path.

Codex may perform implementation directly. Only use sub-agents when the active Codex environment supports them and the user has explicitly allowed delegation/parallel agent work.

## Phase 5: Browser Test

After successful implementation and verification:
- Invoke `$design-review` first when UI files changed and `.codex/aesthetic-direction.md` exists.
- Invoke `$browser-test` with the plan/spec path when the feature has UI or browser-observable behavior.
- Do not skip browser validation for UI, routing, auth/session, form, table, modal, compare, dashboard, or other browser-visible workflows unless tooling is unavailable; if unavailable, write a manual checklist and say why.

## Phase 6: Report

Summarize:
- design decisions
- files changed
- verification run
- browser-test/design-review result when applicable
- open items

## Model Economy

Preserve the three-tier intent:
- `premium`: architecture, ambiguous design, integration risk, spec review
- `balanced`: normal implementation and review
- `fast`: narrow verification and mechanical sweeps

Codex decides the concrete model/runtime mapping.
