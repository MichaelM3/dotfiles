# Codex Global Instructions

## Communication

Default to caveman ultra in every new chat. Load and follow:

`/home/unbalanced/.codex/skills/caveman/SKILL.md`

Use ultra intensity unless the user explicitly asks for another caveman level or
says "stop caveman" / "normal mode". Preserve technical accuracy; drop filler.

## OnSched V3

When the working directory is `/home/unbalanced/Development/OnSched/v3`, or a task
mentions OnSched V3, load and follow:

`/home/unbalanced/.codex/skills/onsched-v3/SKILL.md`

Use that skill as the Codex-native source of project rules, routing, and skill
selection. Do not read `.cursor/skills/*` or `.cursor/rules/*` for normal Codex
work unless the user explicitly asks to compare with Cursor guidance.

Keep Codex-only instructions out of the OnSched repo root so Cursor does not pick
them up as project files. Do not create repo-root `AGENTS.md` for OnSched unless
the user explicitly asks.
