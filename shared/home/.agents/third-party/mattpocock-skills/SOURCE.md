# Matt Pocock Skills Source

Ported from Matt Pocock's public skills repository.

- Upstream: https://github.com/mattpocock/skills
- Commit: `6654f6b60cd9d5be8b54c6fafe44346dabeb3b76`
- Upstream package version: `1.2.3`
- License: MIT, preserved in `LICENSE`

This harness imports the promoted skills listed by upstream's plugin plus the
four existing misc utilities. Upstream beta skills under `skills/in-progress`
are intentionally excluded from the machine-wide stable set.

Local adaptations:

- Project artifacts are rooted at `PROJECT_ROOT/.agents`.
- Compatibility aliases remain for earlier local names.
- Cursor adapters expose every shared non-`codex-*` skill.
- Harness-specific delegation and commit guardrails override upstream defaults.
