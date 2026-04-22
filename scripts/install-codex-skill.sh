#!/usr/bin/env bash
set -euo pipefail

# install-codex-skill.sh
# Installs this repo as a local Codex plugin by symlinking it into ~/plugins,
# upserting a local marketplace entry in ~/.agents/plugins/marketplace.json,
# and copying native skills into $CODEX_HOME/skills.
#
# Usage:
#   bash scripts/install-codex-skill.sh
#   bash scripts/install-codex-skill.sh --force
#
# Environment overrides:
#   CODEX_PLUGIN_PARENT_DIR   default: $HOME/plugins
#   CODEX_MARKETPLACE_PATH    default: $HOME/.agents/plugins/marketplace.json
#   CODEX_MARKETPLACE_ROOT    default: $HOME
#   CODEX_PLUGIN_CACHE_ROOT   default: $HOME/.codex/plugins/cache
#   CODEX_USER_SKILLS_DIR     default: $HOME/.codex/skills

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_NAME="craft-skills"
PLUGIN_PARENT_DIR="${CODEX_PLUGIN_PARENT_DIR:-$HOME/plugins}"
PLUGIN_DEST="$PLUGIN_PARENT_DIR/$PLUGIN_NAME"
MARKETPLACE_PATH="${CODEX_MARKETPLACE_PATH:-$HOME/.agents/plugins/marketplace.json}"
MARKETPLACE_ROOT="${CODEX_MARKETPLACE_ROOT:-$HOME}"
PLUGIN_CACHE_ROOT="${CODEX_PLUGIN_CACHE_ROOT:-$HOME/.codex/plugins/cache}"
PLUGIN_CACHE_DEST="$PLUGIN_CACHE_ROOT/local-plugins/$PLUGIN_NAME"
USER_SKILLS_DIR="${CODEX_USER_SKILLS_DIR:-${CODEX_HOME:-$HOME/.codex}/skills}"
FORCE=0

if [[ "${1:-}" == "--force" ]]; then
  FORCE=1
elif [[ -n "${1:-}" ]]; then
  echo "ERROR: unknown argument: $1" >&2
  echo "Usage: bash scripts/install-codex-skill.sh [--force]" >&2
  exit 2
fi

if [[ ! -f "$REPO_ROOT/.codex-plugin/plugin.json" ]]; then
  echo "ERROR: missing Codex plugin manifest at $REPO_ROOT/.codex-plugin/plugin.json" >&2
  exit 1
fi

mkdir -p "$PLUGIN_PARENT_DIR"
mkdir -p "$(dirname "$MARKETPLACE_PATH")"
mkdir -p "$USER_SKILLS_DIR"

if [[ -e "$PLUGIN_DEST" && ! -L "$PLUGIN_DEST" ]]; then
  if [[ "$FORCE" != "1" ]]; then
    echo "ERROR: $PLUGIN_DEST already exists and is not a symlink." >&2
    echo "Re-run with --force to replace it." >&2
    exit 1
  fi
  rm -rf "$PLUGIN_DEST"
fi

if [[ -L "$PLUGIN_DEST" ]]; then
  current_target="$(readlink "$PLUGIN_DEST")"
  if [[ "$current_target" != "$REPO_ROOT" && "$FORCE" != "1" ]]; then
    echo "ERROR: $PLUGIN_DEST points to $current_target, not $REPO_ROOT." >&2
    echo "Re-run with --force to replace it." >&2
    exit 1
  fi
  rm -f "$PLUGIN_DEST"
fi

ln -s "$REPO_ROOT" "$PLUGIN_DEST"

while IFS= read -r skill_file; do
  skill_dir="$(dirname "$skill_file")"
  skill_name="$(basename "$skill_dir")"
  skill_dest="$USER_SKILLS_DIR/$skill_name"
  skill_marker="$skill_dest/.craft-skills-source"

  if [[ -e "$skill_dest" && ! -L "$skill_dest" ]]; then
    if [[ "$FORCE" != "1" && "$(cat "$skill_marker" 2>/dev/null || true)" != "$skill_dir" ]]; then
      echo "ERROR: $skill_dest already exists and is not a symlink." >&2
      echo "Re-run with --force to replace it." >&2
      exit 1
    fi
    rm -rf "$skill_dest"
  fi

  if [[ -L "$skill_dest" ]]; then
    current_target="$(readlink "$skill_dest")"
    if [[ "$current_target" != "$skill_dir" && "$FORCE" != "1" ]]; then
      echo "ERROR: $skill_dest points to $current_target, not $skill_dir." >&2
      echo "Re-run with --force to replace it." >&2
      exit 1
    fi
    rm -f "$skill_dest"
  fi

  mkdir -p "$skill_dest"
  cp -R "$skill_dir/." "$skill_dest/"
  printf "%s\n" "$skill_dir" > "$skill_marker"
done < <(find "$REPO_ROOT/skills" -mindepth 2 -maxdepth 2 -name SKILL.md -print | sort)

if [[ ! -f "$MARKETPLACE_PATH" ]]; then
  cat > "$MARKETPLACE_PATH" <<'EOF'
{
  "name": "local-plugins",
  "interface": {
    "displayName": "Local Plugins"
  },
  "plugins": []
}
EOF
fi

node - "$MARKETPLACE_PATH" <<'EOF'
const fs = require("fs");

const marketplacePath = process.argv[2];
const raw = fs.readFileSync(marketplacePath, "utf8");
const data = JSON.parse(raw);

if (!data.name) data.name = "local-plugins";
if (!data.interface) data.interface = { displayName: "Local Plugins" };
if (!data.interface.displayName) data.interface.displayName = "Local Plugins";
if (!Array.isArray(data.plugins)) data.plugins = [];

const entry = {
  name: "craft-skills",
  source: {
    source: "local",
    path: "./plugins/craft-skills"
  },
  policy: {
    installation: "INSTALLED_BY_DEFAULT",
    authentication: "ON_INSTALL"
  },
  category: "Development"
};

const index = data.plugins.findIndex((plugin) => plugin && plugin.name === entry.name);
if (index >= 0) {
  data.plugins[index] = entry;
} else {
  data.plugins.push(entry);
}

fs.writeFileSync(marketplacePath, JSON.stringify(data, null, 2) + "\n");
EOF

if command -v codex >/dev/null 2>&1; then
  codex plugin marketplace add "$MARKETPLACE_ROOT"
else
  echo "WARNING: codex CLI not found; marketplace file was written but not registered." >&2
  echo "Register it later with:" >&2
  echo "  codex plugin marketplace add \"$MARKETPLACE_ROOT\"" >&2
fi

if [[ -d "$PLUGIN_CACHE_DEST" ]]; then
  rm -rf "$PLUGIN_CACHE_DEST"
  echo "Cleared Codex plugin cache:"
  echo "  $PLUGIN_CACHE_DEST"
fi

cat <<EOF
Codex plugin and native skills installed locally.

Plugin symlink:
  $PLUGIN_DEST -> $REPO_ROOT

Marketplace entry:
  $MARKETPLACE_PATH

Marketplace root:
  $MARKETPLACE_ROOT

User skills:
  $USER_SKILLS_DIR

Next steps:
  1. Restart or refresh Codex if needed.
  2. Ensure this project has .codex/PROJECT.md.
  3. Generate root host files with:
     bash scripts/sync-host-context.sh "\$PWD"
EOF
