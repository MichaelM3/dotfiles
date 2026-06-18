---
name: skill-authoring
description: Create or revise shared agent skills with progressive disclosure, token-efficient instructions, and verification. Use when the user asks to write, port, organize, audit, or improve skills.
---

# Skill Authoring

## Structure

Every skill needs:

```markdown
---
name: short-kebab-name
description: Capability plus precise trigger conditions.
---

# Skill Title
```

Place shared harness skills under `.agents/skills/<name>/SKILL.md`. Expose each
shared non-`codex-*` skill to Cursor with
`.agents/cursor/skills/<name> -> ../../skills/<name>`. Do not copy shared user
skills into `.codex/skills`.

Add references, scripts, or assets only when they reduce repeated context or
improve deterministic execution.

## Design Rules

- Description carries trigger logic; keep it specific.
- Keep `SKILL.md` concise: target under 60 lines; hard cap 100 unless truly exceptional.
- One skill does one job. Compose router skills from focused skills instead of embedding whole workflows.
- Prefer harness-agnostic language. Put Codex/Cursor/Claude/Pi mechanics in explicit adapter skills or references.
- Move long examples, prompt templates, command snippets, and variants into `references/`; name exactly when to read them.
- Do not include README, changelog, install notes, or process history inside skill folders.
- Avoid person/profile/project-specific names unless the skill is truly scoped that way.

## Verification

After edits:

1. Run `find .agents/skills -mindepth 2 -maxdepth 2 -name SKILL.md -print`.
2. Check YAML frontmatter has `name` and `description`.
3. Confirm descriptions say when to use the skill.
4. Grep for stale source-tool names if porting from another agent.
5. Read the resulting skill as if loaded mid-task: it should say what to do next without extra context.
6. Run the shared harness audit when layout changed:
   `./scripts/audit-agent-harness.sh`.
