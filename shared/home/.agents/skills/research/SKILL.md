---
name: research
description: Investigate a question against high-trust primary sources and capture the findings as a Markdown file in the repo. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
---

When delegation is allowed, spin up a **background agent** so other work can
continue while it reads. Otherwise perform the same process in this session.

Follow `$HOME/.agents/instructions/project-artifacts.md`. Resolve
`PROJECT_ROOT` first. When the repo has no established research-note location,
write `.agents/research/<slug>.md`; never write into the shared skill install.
If delegation is unavailable, perform the same research in the main session.

Its job:

1. Investigate the question against **primary sources** (official docs, source code, specs, first-party APIs), not a secondary write-up of them. Follow every claim back to the source that owns it.
2. Write the findings to a single Markdown file, citing each claim's source.
3. Save it where the repo already keeps such notes; match the existing convention, and if there is none, use `.agents/research/<slug>.md` and report the path.
