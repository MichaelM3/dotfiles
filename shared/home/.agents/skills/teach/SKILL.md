---
name: teach
description: Teach the user a new skill or concept over multiple sessions using the current directory as a stateful teaching workspace.
disable-model-invocation: true
argument-hint: "What would you like to learn about?"
---

# Teach

Teach a topic over multiple sessions. The current directory is the teaching
workspace unless the user gives another path.

## Workspace Files

- `MISSION.md`: why the user is learning this topic. Use
  `references/MISSION-FORMAT.md`.
- `RESOURCES.md`: trusted knowledge sources and communities. Use
  `references/RESOURCES-FORMAT.md`.
- `GLOSSARY.md`: canonical teaching language. Use
  `references/GLOSSARY-FORMAT.md`.
- `learning-records/*.md`: durable insights and demonstrated knowledge. Use
  `references/LEARNING-RECORD-FORMAT.md`.
- `lessons/*.html`: one self-contained lesson per file.
- `reference/*.html`: printable reference documents.
- `assets/*`: reusable lesson components: stylesheets, quiz widgets,
  simulators, and diagram helpers.
- `NOTES.md`: scratchpad for teaching preferences and working notes.

Create files lazily. If the current directory is an unrelated code repo and no
teaching files exist, confirm the workspace path before writing.

## Mission First

Every lesson traces to the mission. If `MISSION.md` is missing or vague, ask
why the user wants to learn the topic before teaching. Update the mission only
after confirming the change with the user.

## Knowledge Before Claims

Use high-trust resources. Before `RESOURCES.md` is populated, search for or ask
for sources rather than relying on parametric knowledge. Cite sources in
lessons and references.

## Lessons

Each lesson is one tightly scoped HTML file under `lessons/`:

- title `0001-<dash-case-name>.html`, incrementing by existing files
- short enough to complete quickly
- directly tied to the mission
- contains retrieval practice or an interactive feedback loop when possible
- links related lessons and reference docs
- recommends one primary source

If possible, open the lesson file for the user after creating it.

## Assets

Reuse is default. Before authoring a lesson, inspect `assets/` and build from
existing components. When a lesson needs something reusable, create it in
`assets/` and link it; do not inline code a future lesson would duplicate.

A shared stylesheet is the first reusable component a workspace should earn.

## Learning Records

Write a learning record when the user demonstrates non-trivial understanding,
discloses prior knowledge, corrects a misconception, or the mission shifts.
Do not write records for material merely covered.
