---
name: skill-authoring
description: Create or revise Codex skills with progressive disclosure, token-efficient instructions, and verification. Use when the user asks to write, port, organize, audit, or improve skills.
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

Place user skills under `$CODEX_HOME/skills/<name>/SKILL.md`. Add references, scripts, or assets only when they reduce repeated context or improve deterministic execution.

## Design Rules

- Description carries trigger logic; keep it specific.
- Body carries procedure; keep it under 500 lines.
- Prefer one focused skill per trigger surface. Consolidate only when workflows are usually invoked together.
- Move long examples or variants into `references/` and mention exactly when to read them.
- Do not include README, changelog, install notes, or process history inside skill folders.
- Avoid project-specific names unless the skill is truly project-specific.

## Verification

After edits:

1. Run `find skills -path '*/SKILL.md' -print`.
2. Check YAML frontmatter has `name` and `description`.
3. Confirm descriptions say when to use the skill.
4. Grep for stale source-tool names if porting from another agent.
5. Read the resulting skill as if loaded mid-task: it should say what to do next without extra context.
