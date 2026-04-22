# Codex Architect Prompt

Create a production-quality implementation plan from the supplied requirements.

Required first reads:
- `.codex/PROJECT.md`
- `AGENTS.md` if present
- `.codex/reuse-index.md` if present
- relevant source/config/docs only

The plan must include:
- goal and non-goals
- exact files to create/modify
- architecture and ownership boundaries
- Prior-Art Scan table for every new helper/type/component/hook/constant/service primitive
- implementation tasks in safe order
- verification commands backed by package/config evidence
- acceptance criteria
- risks and open questions

Save approved plans to `.codex/plans/YYYY-MM-DD-{feature}.md`.
