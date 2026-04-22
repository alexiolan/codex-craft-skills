#!/usr/bin/env bash
set -euo pipefail

# bootstrap-codex-project.sh
# Run from a target project directory to:
# 1. clone or update craft-skills locally
# 2. install craft-skills as a local Codex plugin and native Codex skills
# 3. create .codex/PROJECT.md if missing
# 4. generate AGENTS.md for the current project
#
# Usage:
#   bash <(curl -fsSL https://raw.githubusercontent.com/alexiolan/codex-craft-skills/main/scripts/bootstrap-codex-project.sh)
#   bash /path/to/craft-skills/scripts/bootstrap-codex-project.sh
#
# Environment overrides:
#   CRAFT_SKILLS_REPO_URL   default: https://github.com/alexiolan/codex-craft-skills.git
#   CRAFT_SKILLS_HOME       default: local checkout when run from one, otherwise $HOME/.local/share/codex-craft-skills

TARGET_PROJECT_ROOT="$(pwd)"
CRAFT_SKILLS_REPO_URL="${CRAFT_SKILLS_REPO_URL:-https://github.com/alexiolan/codex-craft-skills.git}"

SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" 2>/dev/null && pwd || true)"
SCRIPT_REPO_ROOT=""
if [[ -n "$SCRIPT_DIR" ]]; then
  candidate="$(cd "$SCRIPT_DIR/.." 2>/dev/null && pwd || true)"
  if [[ -n "$candidate" && -f "$candidate/.codex-plugin/plugin.json" && -f "$candidate/scripts/install-codex-skill.sh" ]]; then
    SCRIPT_REPO_ROOT="$candidate"
  fi
fi

if [[ -n "${CRAFT_SKILLS_HOME:-}" ]]; then
  CRAFT_SKILLS_HOME="$CRAFT_SKILLS_HOME"
elif [[ -n "$SCRIPT_REPO_ROOT" ]]; then
  CRAFT_SKILLS_HOME="$SCRIPT_REPO_ROOT"
else
  CRAFT_SKILLS_HOME="$HOME/.local/share/codex-craft-skills"
fi

if ! command -v git >/dev/null 2>&1; then
  echo "ERROR: git is required to bootstrap craft-skills." >&2
  exit 1
fi

if ! command -v codex >/dev/null 2>&1; then
  echo "ERROR: codex CLI is required. Install it first with:" >&2
  echo "  npm i -g @openai/codex" >&2
  echo "Then run:" >&2
  echo "  codex login" >&2
  exit 1
fi

if [[ ! -d "$TARGET_PROJECT_ROOT" ]]; then
  echo "ERROR: current working directory does not exist: $TARGET_PROJECT_ROOT" >&2
  exit 1
fi

mkdir -p "$(dirname "$CRAFT_SKILLS_HOME")"

if [[ -n "$SCRIPT_REPO_ROOT" && "$CRAFT_SKILLS_HOME" == "$SCRIPT_REPO_ROOT" ]]; then
  echo "Using local craft-skills checkout at $CRAFT_SKILLS_HOME"
elif [[ -d "$CRAFT_SKILLS_HOME/.git" ]]; then
  echo "Updating craft-skills in $CRAFT_SKILLS_HOME"
  git -C "$CRAFT_SKILLS_HOME" pull --ff-only
else
  if [[ -e "$CRAFT_SKILLS_HOME" ]]; then
    echo "ERROR: $CRAFT_SKILLS_HOME exists but is not a git checkout." >&2
    echo "Remove it or set CRAFT_SKILLS_HOME to another path." >&2
    exit 1
  fi
  echo "Cloning craft-skills into $CRAFT_SKILLS_HOME"
  git clone "$CRAFT_SKILLS_REPO_URL" "$CRAFT_SKILLS_HOME"
fi

echo "Installing craft-skills into Codex"
bash "$CRAFT_SKILLS_HOME/scripts/install-codex-skill.sh"

mkdir -p "$TARGET_PROJECT_ROOT/.codex/plans/specs"
mkdir -p "$TARGET_PROJECT_ROOT/.codex/plans/archive"
mkdir -p "$TARGET_PROJECT_ROOT/.codex/prompts"

if [[ ! -f "$TARGET_PROJECT_ROOT/.codex/PROJECT.md" ]]; then
  cat > "$TARGET_PROJECT_ROOT/.codex/PROJECT.md" <<'EOF'
# Project Context

This file is the canonical Codex project context for this project.

## Project Purpose

[TODO: describe what this project does]

## Runtime Model

- Host orchestrator: `codex`
- Local LLM capability: optional
- Routing policy: `default` or `ace`

## Architecture

- [TODO: describe module/package structure]
- [TODO: describe shared/common module rules]
- [TODO: describe important boundaries]

## Commands

- Dev: [TODO]
- Lint: [TODO]
- Typecheck: [TODO]
- Build: [TODO]
- Test: [TODO]

## Conventions

- [TODO: describe naming and export conventions]
- [TODO: describe data layer / UI / integration patterns]
- [TODO: describe verification expectations]
EOF
  echo "Created starter .codex/PROJECT.md in $TARGET_PROJECT_ROOT"
fi

echo "Generating root Codex context for $TARGET_PROJECT_ROOT"
bash "$CRAFT_SKILLS_HOME/scripts/sync-host-context.sh" "$TARGET_PROJECT_ROOT"

cat <<EOF
craft-skills bootstrap complete.

craft-skills repo:
  $CRAFT_SKILLS_HOME

Target project:
  $TARGET_PROJECT_ROOT

Generated files:
  $TARGET_PROJECT_ROOT/.codex/PROJECT.md
  $TARGET_PROJECT_ROOT/AGENTS.md

Next steps:
  1. Ask Codex to initialize the project context with this prompt:

     Initialize craft-skills for this project.

     Read the repository structure, package/config files, existing README/docs,
     and common source directories. Update .codex/PROJECT.md with:
     - project purpose
     - module/package structure
     - architecture boundaries
     - development commands for dev, lint, typecheck, build, and test
     - coding conventions and export/import rules
     - data layer, UI, and integration patterns
     - verification expectations

     Then run:
     bash "$CRAFT_SKILLS_HOME/scripts/sync-host-context.sh" "$TARGET_PROJECT_ROOT"

     Do not invent commands. If a command is unclear, mark it as TODO with
     the evidence you checked.

  2. After editing .codex/PROJECT.md manually or via Codex, re-run:
     bash "$CRAFT_SKILLS_HOME/scripts/sync-host-context.sh" "$TARGET_PROJECT_ROOT"
  3. Restart or refresh Codex if needed.
  4. Start workflows in Codex with native skill invocation, for example:
     \$craft Add a user notifications system

     Codex does not currently expose custom plugin slash commands, so use
     \$craft instead of /craft.
EOF
