# Codex Host Adapter

This directory defines how `codex-craft-skills` runs in Codex.

Codex is always the orchestrator.

## Responsibilities

- own the main workflow
- map shared model tiers to Codex-specific execution choices
- define how Codex performs planning, implementation routing, review, and verification
- consume generated `AGENTS.md` at repo root as the Codex compatibility file

## Non-responsibilities

- do not redefine core workflow phases
- do not depend conceptually on any other host being present
- do not store canonical project facts that belong in `.codex/PROJECT.md`

## Relationship to the public skills

Public skill entrypoints are native Codex skills invoked as `$craft`, `$implement`, `$debug`, and related names.
