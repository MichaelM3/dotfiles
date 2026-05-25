# Harness Routing

Use `/home/unbalanced/.agents/AGENTS.md` as the shared entry point for agent
harnesses. Harness-local `AGENTS.md` files should stay as small shims:

1. Load and follow `/home/unbalanced/.agents/AGENTS.md`.
2. Add harness-specific runtime notes only when the harness needs them.
3. Leave project-specific behavior to project-local `AGENTS.md`, `CONTEXT.md`,
   ADRs, or skills.

Expected shared layout:

- `AGENTS.md`: shared operating guide.
- `skills/`: harness-neutral user skills.
- `codex/agents/`: Codex `.toml` custom-agent definitions.
- `cursor/agents/`: Cursor `.md` custom-agent definitions.
- `cursor/skills/`: Cursor adapter links plus Cursor-only skills.
- `cursor/rules/`: Cursor-compatible always-on rules.
- `instructions/`: reusable instruction fragments.
- `templates/`: copy-ready harness and project templates.

Codex currently discovers custom agents from `~/.codex/agents`, so each Codex
profile should symlink its `agents` entry to `~/.agents/codex/agents`. Cursor
discovers user custom agents from `~/.cursor/agents`, user skills from
`~/.cursor/skills`, and user rules from `~/.cursor/rules`, so those entries
should point to the matching adapter paths under `~/.agents/cursor`.
