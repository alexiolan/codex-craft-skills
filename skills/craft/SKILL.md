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

First action:

```bash
cat > .codex/craft-profile <<EOF
host=codex
local_llm=off
routing_policy=default
EOF
```

## Phase 1: Brainstorm

1. Read `.codex/PROJECT.md` and root `AGENTS.md` if present.
2. Inspect only relevant source directories, package/config files, and existing docs.
3. Check recent git context with `git log --oneline -10`.
4. If graph or local LLM tooling is available, use it as optional context only; Codex remains orchestrator.
5. Ask clarifying questions one at a time.
6. Propose 2-3 approaches with trade-offs and lead with a recommendation.
7. Present the selected design and wait for user approval.

## Phase 2: Spec

Before writing the spec, ensure the Codex project folders exist:

```bash
mkdir -p .codex/plans/specs .codex/plans/archive .codex/prompts
```

If `.codex/reuse-index.md` is missing and the feature may introduce shared utilities, hooks, components, types, constants, or helpers, invoke `$reuse-index` or explain that the reuse gate is skipped.

For UI work, if `.codex/aesthetic-direction.md` is missing, invoke `$aesthetic-direction` or explain that the design contract is skipped.

Write the approved design to:

```text
.codex/plans/specs/YYYY-MM-DD-{feature}-design.md
```

The spec must include a Prior-Art Scan table for every new concept it introduces. Cite `.codex/reuse-index.md` when present.

Review the spec for placeholders, contradictions, ambiguity, and scope creep. Present the spec path and wait for user approval before planning implementation.

## Phase 3: Plan

Create an implementation plan with:
- exact file paths
- task ordering
- parallel/sequential dependencies
- verification commands
- acceptance criteria
- rollback or risk notes when relevant

Save the approved plan to:

```text
.codex/plans/YYYY-MM-DD-{feature}.md
```

Wait for user approval before developing.

## Phase 4: Develop

Invoke `$develop` with the approved plan path.

Codex may perform implementation directly. Only use sub-agents when the active Codex environment supports them and the user has explicitly allowed delegation/parallel agent work.

## Phase 5: Browser Test

After successful implementation and verification, invoke `$browser-test` with the plan/spec path when the feature has UI or browser-observable behavior.

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
