---
name: git-guardrails-claude-code
description: Set up guardrails that block dangerous git commands, with Claude Code hooks only when explicitly requested. Use when the user asks for git safety hooks, wants to block push/reset/clean/force operations, or asks for Claude Code git guardrails.
---

# Git Guardrails

Install command guardrails only after the user confirms target harness and
scope. This skill is agent-neutral; use Claude Code hook settings only when the
user explicitly asks for Claude Code.

## Blocks

- `git push`, including force push
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .`
- `git restore .`

## Process

1. Ask target: project-local or user-global, and which harness/shell should
   enforce it.
2. Copy `scripts/block-dangerous-git.sh` to the target hook/script directory.
3. Make it executable.
4. Merge config into existing hook settings; never overwrite unrelated config.
5. Ask whether to add/remove blocked patterns.
6. Verify with a blocked command sample and an allowed command sample.

## Claude Code Hook

Only for explicit Claude Code requests:

- Project script: `.claude/hooks/block-dangerous-git.sh`
- Global script: `~/.claude/hooks/block-dangerous-git.sh`
- Hook type: `PreToolUse`
- Matcher: `Bash`

If `.claude/settings.json` exists, merge into `hooks.PreToolUse`. If it does
not exist, create the minimal settings file only after confirmation.

## Other Harnesses

If the active harness has no pre-command hook support, create only the reusable
script and documented invocation. Do not pretend enforcement exists.
