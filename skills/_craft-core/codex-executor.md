# Codex Executor Guide

Codex is the native executor and orchestrator.

Use `codex exec` only for explicit bounded subprocess workflows. Most interactive runs should let the current Codex session implement directly.

When subprocess execution is needed:
- keep prompts bounded
- provide exact allowed files
- request structured status
- verify results in the orchestrating Codex session

Do not model Codex as a worker for another host in this repository.
