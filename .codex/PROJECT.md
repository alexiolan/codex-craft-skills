# codex-craft-skills Project Context

This file is the canonical Codex project context for `codex-craft-skills`.

Generated compatibility output:
- `AGENTS.md` at repo root

Do not treat generated host files as the source of truth. Update this file first, then regenerate `AGENTS.md`.

## Project Purpose

`codex-craft-skills` provides Codex-native structured development workflows:
- brainstorm before implementation
- plan explicitly
- execute in bounded tasks
- verify results
- review quality and reuse

Codex is always the orchestrator. Local LLM support is optional hands/review capacity, never the orchestrator.

## Runtime Model

- Host orchestrator: `codex`
- Local LLM capability: optional
- Routing policy: `default` or `ace`
- Shared workflow phases:
  1. Brainstorm
  2. Plan
  3. Develop
  4. Browser Test
  5. Report

## Supported Skill Surfaces

- `craft`: Codex orchestrator, no local LLM required
- `craft-local`: Codex orchestrator with local LLM assistance enabled
- `craft-ace`: Codex orchestrator with local LLM as the default hands for eligible tasks
- Step skills: `architect`, `implement`, `finalize`, `develop`, `browser-test`, `debug`, `simplify`, `reflect`

Codex invocation uses `$craft`, `$implement`, and other `$skill` names. `/craft` is not a Codex command.

## Repository Architecture

- `.codex/`: canonical project context, plans, prompts, generated metadata
- `skills/_craft-core/`: shared Codex workflow and policy references
- `hosts/codex/`: Codex orchestration adapter docs
- `skills/`: public Codex skill entrypoints and workflow docs
- `scripts/`: Codex install/bootstrap/sync and local LLM scripts
- `commands/`: forward-compatible command wrapper docs
- `references/`: optional implementation references

## Commands

- Install dependencies: `npm install`
- Validate package metadata: `npm pack --dry-run`
- Inspect changed files: `git status --short`
- Install Codex plugin/native skills locally: `bash scripts/install-codex-skill.sh`
- Sync generated Codex context: `bash scripts/sync-host-context.sh "$PWD"`

Script verification for this repo should favor:
- `bash -n` for shell scripts
- targeted markdown/doc review for workflow changes

## Conventions

- Keep workflow semantics Codex-native in core docs.
- Keep Codex-specific orchestration behavior under `hosts/codex/`.
- Preserve a tiered model-economy policy:
  - `premium` for deep reasoning, architecture, integration
  - `balanced` for standard implementation and review
  - `fast` for mechanical sweeps and narrow verification
- Do not describe Claude as part of the Codex runtime.

## Migration Expectations

- This branch is intentionally breaking from the Claude plugin.
- Downstream Codex projects should use `.codex/PROJECT.md`, `.codex/plans`, `.codex/prompts`, `.codex/reuse-index.md`, and `.codex/aesthetic-direction.md`.
- Existing Claude users should stay on the Claude-oriented repository/branch.
