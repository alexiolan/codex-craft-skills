#!/usr/bin/env bash
set -euo pipefail

# read-runtime-state.sh
# Reads .codex/craft-profile runtime state and prints shell exports.
#
# Usage:
#   eval "$(bash scripts/read-runtime-state.sh <project-root>)"

PROJECT_ROOT="${1:-}"
if [[ -z "$PROJECT_ROOT" ]]; then
  echo "ERROR: project root required as first argument" >&2
  echo "Usage: read-runtime-state.sh <project-root>" >&2
  exit 2
fi

PROFILE_FILE="$PROJECT_ROOT/.codex/craft-profile"

HOST="codex"
LOCAL_LLM="off"
ROUTING_POLICY="default"

if [[ -f "$PROFILE_FILE" ]]; then
  while IFS='=' read -r raw_key raw_value; do
    key="$(printf '%s' "${raw_key:-}" | tr -d '[:space:]')"
    value="$(printf '%s' "${raw_value:-}" | tr -d '[:space:]')"
    case "$key" in
      host) HOST="${value:-$HOST}" ;;
      local_llm) LOCAL_LLM="${value:-$LOCAL_LLM}" ;;
      routing_policy) ROUTING_POLICY="${value:-$ROUTING_POLICY}" ;;
    esac
  done < "$PROFILE_FILE"
fi

if [[ "$LOCAL_LLM" == "on" ]]; then
  LLM_ENABLED=1
else
  LLM_ENABLED=0
fi

if [[ "$ROUTING_POLICY" == "ace" ]]; then
  ACE_ENABLED=1
else
  ACE_ENABLED=0
fi

if [[ "$HOST" == "codex" ]]; then
  CODEX_HOST=1
else
  CODEX_HOST=0
fi

cat <<EOF
export CRAFT_HOST="$HOST"
export CRAFT_LOCAL_LLM="$LOCAL_LLM"
export CRAFT_ROUTING_POLICY="$ROUTING_POLICY"
export LLM_ENABLED="$LLM_ENABLED"
export ACE_ENABLED="$ACE_ENABLED"
export CODEX_HOST="$CODEX_HOST"
EOF
