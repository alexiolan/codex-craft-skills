# codex-craft-skills

Codex-native development workflows for planning, implementation, browser testing, debugging, and review.

This branch is intentionally Codex-only. The Claude version should stay separate and keep its `.claude` behavior. Codex uses native skill invocation (`$craft`, `$implement`, `$debug`) and project artifacts under `.codex`.

## Install

Install and authenticate Codex CLI:

```bash
npm i -g @openai/codex
codex login
```

Bootstrap from a project terminal:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/alexiolan/codex-craft-skills/main/scripts/bootstrap-codex-project.sh)
```

For local development from this repo:

```bash
bash scripts/install-codex-skill.sh
```

The installer:
- registers this repo as a local Codex plugin
- copies native skills into `~/.codex/skills`
- registers the local marketplace root for Codex

Restart Codex after installing.

## Start A Project

From the target project root:

```bash
bash ~/.local/share/codex-craft-skills/scripts/bootstrap-codex-project.sh
```

Then open Codex in that project:

```bash
codex
```

Ask Codex to initialize the project profile:

```text
Initialize codex-craft-skills for this project.

Read the repository structure, package/config files, existing README/docs, and common source directories. Update `.codex/PROJECT.md` with:
- project purpose
- module/package structure
- architecture boundaries
- development commands for dev, lint, typecheck, build, and test
- coding conventions and export/import rules
- data layer, UI, and integration patterns
- verification expectations

Then run:
bash ~/.local/share/codex-craft-skills/scripts/sync-host-context.sh "$PWD"

Do not invent commands. If a command is unclear, mark it as TODO with the evidence you checked.
```

## Use

Codex skills are invoked with `$`, not `/`.

```text
$craft Add a user notifications system
$implement Add a logout button
$architect Plan a read-only health page
$debug The API returns 500 on save
$simplify
$reflect project
```

If the plugin-prefixed form appears in your Codex skill list, this also works:

```text
$craft-skills:craft Add a user notifications system
```

`/craft` is not a Codex command.

## Skill Surface

Pipeline skills:
- `craft` — full Brainstorm → Plan → Develop → Browser Test → Report workflow
- `craft-local` — same pipeline with LM Studio local-model assistance
- `craft-ace` — Codex remains orchestrator while the local model is default hands for eligible tasks

Step skills:
- `architect`
- `implement`
- `finalize`
- `develop`
- `browser-test`
- `debug`
- `simplify`
- `reflect`

Support skills:
- `aesthetic-direction`
- `ux-brief`
- `design-review`
- `reuse-index`
- `graph-explore`
- `llm-review`

## Project Files

Codex project state lives under `.codex`:

```text
.codex/
├── PROJECT.md
├── plans/
│   ├── specs/
│   └── archive/
├── prompts/
├── aesthetic-direction.md
└── reuse-index.md
```

`AGENTS.md` is generated from `.codex/PROJECT.md` because current Codex CLI reads root `AGENTS.md`. Treat `.codex/PROJECT.md` as the source of truth and `AGENTS.md` as generated compatibility output.

Regenerate it with:

```bash
bash scripts/sync-host-context.sh "$PWD"
```

## Local LLM

`craft-local` and `craft-ace` use LM Studio when available.

```bash
export LLM_URL="http://localhost:1234"
export LLM_MODEL="your/model-id"
```

Then in Codex:

```text
$craft-local Add a data export page
$craft-ace Refactor the reports table
```

## Repository Layout

```text
codex-craft-skills/
├── .codex-plugin/          # Codex plugin manifest
├── .codex/PROJECT.md       # This repo's Codex project context
├── skills/                 # Native Codex skill entrypoints
├── hosts/codex/            # Codex orchestration notes
├── scripts/                # Install, bootstrap, render, LLM helpers
├── commands/               # Forward-compatible command wrappers
└── references/             # Optional implementation references
```

## Verification

For this repo:

```bash
bash -n scripts/install-codex-skill.sh
bash -n scripts/bootstrap-codex-project.sh
bash -n scripts/sync-host-context.sh
npm pack --dry-run
```
