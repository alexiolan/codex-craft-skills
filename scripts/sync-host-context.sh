#!/usr/bin/env bash
set -euo pipefail

# sync-host-context.sh
# Generates root AGENTS.md from .codex/PROJECT.md.
#
# Usage:
#   sync-host-context.sh <project-root>

PROJECT_ROOT="${1:-}"
if [[ -z "$PROJECT_ROOT" ]]; then
  echo "ERROR: project root required as first argument" >&2
  echo "Usage: sync-host-context.sh <project-root>" >&2
  exit 2
fi

if [[ ! -d "$PROJECT_ROOT" ]]; then
  echo "ERROR: project root does not exist: $PROJECT_ROOT" >&2
  exit 2
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_MD="$PROJECT_ROOT/.codex/PROJECT.md"

if [[ ! -f "$PROJECT_MD" ]]; then
  echo "ERROR: canonical project context not found: $PROJECT_MD" >&2
  exit 1
fi

bash "$SCRIPT_DIR/render-agents-md.sh" "$PROJECT_ROOT"

echo "Codex context synced from $PROJECT_MD"
