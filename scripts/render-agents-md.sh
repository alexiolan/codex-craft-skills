#!/usr/bin/env bash
set -euo pipefail

# render-agents-md.sh
# Renders root AGENTS.md from .codex/PROJECT.md.
#
# Usage:
#   render-agents-md.sh <project-root>

PROJECT_ROOT="${1:-}"
if [[ -z "$PROJECT_ROOT" ]]; then
  echo "ERROR: project root required as first argument" >&2
  echo "Usage: render-agents-md.sh <project-root>" >&2
  exit 2
fi

if [[ ! -d "$PROJECT_ROOT" ]]; then
  echo "ERROR: project root does not exist: $PROJECT_ROOT" >&2
  exit 2
fi

PROJECT_MD="$PROJECT_ROOT/.codex/PROJECT.md"
if [[ ! -f "$PROJECT_MD" ]]; then
  echo "ERROR: canonical project context not found: $PROJECT_MD" >&2
  exit 1
fi

PARENT_PROJECT_MD=""
if [[ -f "$PROJECT_ROOT/../.codex/PROJECT.md" ]]; then
  PARENT_PROJECT_MD="$PROJECT_ROOT/../.codex/PROJECT.md"
fi

AGENTS_MD="$PROJECT_ROOT/AGENTS.md"

{
  cat <<'PREAMBLE'
# AGENTS.md

> This file is generated from `.codex/PROJECT.md` by `scripts/render-agents-md.sh`.
> Do NOT edit directly. Edit `.codex/PROJECT.md` and re-run `scripts/sync-host-context.sh`.

## Codex Host Notes

These rules apply to Codex executions in this project:

- Respect the canonical project context exactly.
- Do NOT reformat unrelated code.
- Keep changes scoped to the assigned task.
- Match existing patterns and file-local style.
- Do not add files outside the intended scope.
- Update shared state artifacts when the workflow requires it.

---

PREAMBLE

  if [[ -n "$PARENT_PROJECT_MD" ]]; then
    echo "## Parent Project Context"
    echo ""
    cat "$PARENT_PROJECT_MD"
    echo ""
    echo "---"
    echo ""
  fi

  echo "## Project Context"
  echo ""
  cat "$PROJECT_MD"
} > "$AGENTS_MD"

echo "AGENTS.md written to $AGENTS_MD"
