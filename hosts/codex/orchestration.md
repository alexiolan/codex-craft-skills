# Codex Orchestration

When `craft-skills` runs inside Codex:

- Codex is the orchestrator
- the same public skills (`craft`, `craft-local`, `craft-ace`, `architect`, `develop`, and others) remain valid
- host-specific behavior belongs here, not in mixed-host variant docs

## Core orchestration pattern

1. Read canonical project context and generated host files
2. Explore targeted codebase context
3. Brainstorm with the user before implementation
4. Save spec and plan artifacts
5. Dispatch bounded implementation/review tasks using Codex-native orchestration
6. Verify outcomes before reporting completion

## Local-model interaction

- `craft-local`: local model is supplemental
- `craft-ace`: local model is the default hands for eligible tasks
- Codex remains responsible for architecture, integration, fallbacks, and final quality judgment

## Guardrail

Codex orchestration must be documented as first-class behavior. It should not be described as a subprocess or worker for another host.
