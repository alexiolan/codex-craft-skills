# Codex Develop

This file explains how the `develop` phase should behave when Codex is the host orchestrator.

## Shared basis

Read first:
- `skills/_craft-core/develop-routing.md`
- `skills/_craft-core/host-policy.md`
- `skills/_craft-core/project-context.md`

## Codex-host defaults

- Data layer: usually `balanced`
- UI: usually `balanced`
- Integration: usually `premium`
- Mechanical fixes: usually `fast` or `balanced` depending on ambiguity

## Delegation

- `craft`: Codex executes most tasks through host-native orchestration
- `craft-local`: Codex may use the local model as supplemental hands or reviewer
- `craft-ace`: Codex remains orchestrator while the local model becomes the default hands for eligible bounded tasks

## Guardrail

Codex `develop` owns planning context, task routing, implementation, verification, and final judgment.
