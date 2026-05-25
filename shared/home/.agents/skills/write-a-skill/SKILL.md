---
name: write-a-skill
description: Compatibility adapter for skill-authoring. Use when the user asks to write a skill, create a new skill, port a skill, or invokes Matt Pocock's write-a-skill name.
---

# Write A Skill

Compatibility adapter. Load and follow:

`/home/unbalanced/.agents/skills/skill-authoring/SKILL.md`

Use shared harness layout:

- Shared skill: `.agents/skills/<name>/SKILL.md`
- Optional references: `.agents/skills/<name>/references/`
- Optional scripts: `.agents/skills/<name>/scripts/`
- Cursor exposure: `.agents/cursor/skills/<name> -> ../../skills/<name>`

Do not write shared user skills into `.codex/skills`.
