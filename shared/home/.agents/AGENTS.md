# Shared Agent Harness Guide

This directory is the shared home for agent harness instructions, custom
agents, reusable skills, and templates. Harness-specific config files should
load this file, then add only the smallest harness-local override needed.

## Communication

Default to caveman ultra in every new chat. Load and follow:

`/home/unbalanced/.agents/skills/caveman/SKILL.md`

Use ultra intensity unless the user explicitly asks for another caveman level or
says "stop caveman" / "normal mode". Preserve technical accuracy; drop filler.

## Priority

1. User request and current conversation.
2. Repository-local `AGENTS.md`, `CONTEXT.md`, ADRs, and framework docs.
3. Shared instructions, skills, and agents in `/home/unbalanced/.agents/`.
4. Harness-native global skills and system instructions.
5. Existing code style and tests.

## Default Workflow

1. Read before editing. Use `rg`, `rg --files`, and targeted file reads.
2. State concise progress updates during longer work.
3. Keep changes scoped to the requested behavior.
4. Preserve user changes. Never reset or revert unrelated work.
5. Verify with the narrowest useful command, then broader checks when risk warrants it.
6. Report changed files, verification, and any remaining risk.

## Shared Paths

- Shared guide: `/home/unbalanced/.agents/AGENTS.md`.
- Shared skills: `/home/unbalanced/.agents/skills/`.
- Codex custom agents: `/home/unbalanced/.agents/codex/agents/`.
- Cursor custom agents: `/home/unbalanced/.agents/cursor/agents/`.
- Shared instructions: `/home/unbalanced/.agents/instructions/`.
- Shared Cursor rules: `/home/unbalanced/.agents/cursor/rules/`.
- Shared templates: `/home/unbalanced/.agents/templates/`.

Harness configs should reference these paths instead of duplicating shared
rules. Keep project-specific skills and instructions out of this shared root
unless they apply to every repo.

## Sub-Agent Capabilities

Load and follow:

`/home/unbalanced/.agents/skills/sub-agent-capabilities/SKILL.md`

Use GPT-5.5 with high reasoning as the main Orchestrator brain. Keep
agent trees bounded by `max_depth = 1`. Codex custom sub-agents live in
`/home/unbalanced/.agents/codex/agents/`.

Use `cavecrew` only when the user explicitly allows subagents or asks for
delegation. Keep delegated tasks bounded and outputs path-first.

## Skill Map

- Terse mode: `caveman`.
- Compressed sub-agent output: `cavecrew`.
- Codex orchestration: `codex-mini-orchestrate`.
- Commit generation: `generate-commits`.
- PR summaries: `pr-summary`.
- Sub-agent policy: `sub-agent-capabilities`.
- Plan checks: `verify-plan`.
- Debugging: `diagnose`.
- Test-first work: `tdd`.
- Refactoring and system shape: `architecture`.
- Architecture compatibility name: `improve-codebase-architecture`.
- PRDs, plans, issues, grilling: `planning`, `to-prd`, `to-issues`,
  `grill-me`, `grill-with-docs`, `zoom-out`.
- Matt-style project setup: `setup-matt-pocock-skills`.
- Issue readiness: `triage`.
- Throwaway exploration: `prototype`.
- Handoffs: `handoff`.
- Skill writing: `skill-authoring`, `write-a-skill`.
- Skill discovery: `find-skills`.
- Misc repo tools: `git-guardrails-claude-code`, `migrate-to-shoehorn`,
  `scaffold-exercises`, `setup-pre-commit`.
- Caveman variants: `caveman-review`, `caveman-commit`,
  `caveman-compress`, `caveman-stats`, `caveman-help`.

## Context Traversal

Start broad, then narrow:

1. Inventory files and scripts.
2. Read project docs and command definitions.
3. Search names from the user request.
4. Trace callers, tests, and runtime entry points.
5. Edit only after the relevant path is understood.

For monorepos, locate the nearest package/workspace instructions before assuming
root commands apply.

## Verification

Prefer evidence over confidence:

- Bug fix: failing repro/test first when practical, then passing repro/test.
- Feature: focused behavior test or manual run through the new path.
- Refactor: existing tests plus spot checks at changed interfaces.
- Docs/skills: frontmatter validation, file discovery, and a read-through for trigger clarity.

If verification cannot run, say exactly why and name the command that should run
next.

## Project Artifacts

Matt-style project docs live under `PROJECT_ROOT/.agents`. Load and follow:

`/home/unbalanced/.agents/instructions/project-artifacts.md`

## Project-Specific Rules

Do not put OnSched, Cursor, repo-specific migration, availability, or release
skills in this shared agent home. Those belong in project-local config or a
separate profile.
