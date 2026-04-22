#!/usr/bin/env bash
set -euo pipefail

# sync-agents-md.sh
# Compatibility wrapper. The canonical source is now .codex/PROJECT.md.
#
# Usage:
#   sync-agents-md.sh <project-root>
#
# Exits 0 on success, non-zero on failure. Idempotent.

PROJECT_ROOT="${1:-}"
if [[ -z "$PROJECT_ROOT" ]]; then
  echo "ERROR: project root required as first argument" >&2
  echo "Usage: sync-agents-md.sh <project-root>" >&2
  exit 2
fi

if [[ ! -d "$PROJECT_ROOT" ]]; then
  echo "ERROR: project root does not exist: $PROJECT_ROOT" >&2
  exit 2
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "$SCRIPT_DIR/sync-host-context.sh" "$PROJECT_ROOT"
