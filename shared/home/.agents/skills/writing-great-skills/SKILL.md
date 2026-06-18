---
name: writing-great-skills
description: Reference for writing and editing skills well: predictable invocation, crisp steps, progressive disclosure, and pruning.
disable-model-invocation: true
---

# Writing Great Skills

A skill wrangles predictability out of a stochastic system. Predictability
means the agent follows the same process every run, not that it emits the same
output.

Bold terms are defined in `references/GLOSSARY.md`.

## Invocation

- Model-invoked skills keep a `description`; the agent can fire them
  autonomously and other skills can point at them. They spend context load.
- User-invoked skills set `disable-model-invocation: true`; the human must
  type them. They spend cognitive load, not context load.
- Use a router skill when user-invoked skills become hard to remember.

Pick model-invocation only when the agent must reach the skill on its own or
another skill must call it.

## Description

A model-invoked description states the capability and the branches that should
trigger it. Front-load the leading word. Keep one trigger per branch. Cut
identity that the body already explains.

## Information Hierarchy

Put content where the agent needs it:

1. In-skill steps: ordered actions with checkable completion criteria.
2. In-skill reference: rules needed on most runs.
3. External reference: material behind a context pointer, loaded only when that
   branch needs it.

Disclose long examples, variants, templates, and glossaries into separate
files. Keep definitions, rules, and caveats for one concept co-located.

## Split Rules

- Split by invocation when a distinct leading word should trigger independent
  model behavior.
- Split by sequence when later steps tempt premature completion of earlier
  work.
- Do not split merely because a file is long; first prune no-ops and disclose
  branch-only reference.

## Pruning

Keep each meaning in one authoritative place. Check every sentence for
relevance and no-op behavior: would the agent act differently without it? If
not, delete the sentence.

## Failure Modes

- Premature completion: a step ends before its criterion is met.
- Duplication: the same meaning has two sources of truth.
- Sediment: stale layers accumulate because adding feels safer than removing.
- Sprawl: live content is still too long for the top-level skill.
- No-op: an instruction restates default behavior.
