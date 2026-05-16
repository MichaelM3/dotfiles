---
name: cavecrew
description: >-
  Terse subagent-output presets for investigator, builder, and reviewer work when delegation is allowed by sub-agent-capabilities. Keeps tool results caveman-terse (~60% smaller than verbose exploration). Trigger: delegate to subagent, use cavecrew, spawn investigator/builder/reviewer, save context, compressed agent output.
---

Cavecrew = three **presets** (investigator / builder / reviewer). Goal: subagent returns compressed, structured text so main thread context lasts longer.

**Invocation:** Load when delegation is useful and allowed by **sub-agent-capabilities**. This skill does not decide delegation policy; it only shapes concise subagent prompts/results. User can still invoke manually.

**Codex Preset Mapping**

| Preset | Codex use | Notes |
|--------|-----------|--------|
| investigator | `explorer` / Researcher subagent | Locate defs, callers, tests — file:line first |
| builder | `worker` / Developer subagent | <=2 files, surgical edit; refuse broad refactors |
| reviewer | main thread or subagent | One-line findings; prefixes (`bug:`, `risk:`, `nit:`, `q:`) |

## When to use cavecrew vs alternatives

| Task | Use |
|---|---|
| Where is X / what calls Y / list uses of Z | investigator preset |
| Same + architecture essay | Main thread or verbose subagent prompt |
| Surgical edit, ≤2 files, scope obvious | builder preset |
| New feature / 3+ files / cross-cutting refactor | Main thread; split work |
| Review diff for bugs | reviewer preset |
| Deep review + long rationale | normal prose review, not cavecrew |
| One-line answer you know | Main thread, no subagent |

Rule of thumb: **want ~1/3 tokens in tool result → cavecrew. Want prose → normal prose or inline.**

## Why this exists (the real win)

Subagent tool results inject verbatim into main context. Verbose exploration burns budget; terse path:line lists cost less per delegation.

## Output contracts

What main thread can rely on per agent:

**`cavecrew-investigator`**
```
<Header>:
- path:line — `symbol` — short note
totals: <counts>.
```
Or `No match.` Always file-path-first, line-number-attached, backticked symbols. Safe to grep with `path:\d+`.

**`cavecrew-builder`**
```
<path:line-range> — <change ≤10 words>.
verified: <re-read OK | mismatch @ path:line>.
```
Or one of: `too-big.` / `needs-confirm.` / `ambiguous.` / `regressed.` (terminal first token).

**`cavecrew-reviewer`**
```
path:line: <severity>: <problem>. <fix>.
totals: Nbug Nrisk Nnit Nq
```
(`severity` = `bug` | `risk` | `nit` | `q`.) Or `No issues.` Findings sorted file → line ascending.

## Chaining patterns

**Locate → fix → verify** (most common):
1. `cavecrew-investigator` returns site list.
2. Main thread picks 1-2 sites, hands paths to `cavecrew-builder`.
3. `cavecrew-reviewer` audits the diff.

**Parallel scout** (when investigation is broad):
Spawn 2-3 `cavecrew-investigator` calls in one message (different angles: defs vs callers vs tests). Aggregate in main thread.

**Single-shot edit** (when site is already known):
Skip investigator. Hand exact path:line to `cavecrew-builder` directly.

## What NOT to do

- Don't use `cavecrew-builder` when you don't already know the file. Spawn investigator first or main thread will eat tokens passing context.
- Don't chain `cavecrew-investigator → cavecrew-builder` for a 5-file refactor. Builder will return `too-big.` and you'll have wasted a turn.
- Don't ask `cavecrew-reviewer` for "general feedback" — findings only, no architecture opinions. Use verbose main-thread review instead.
- Don't expect prose. Cavecrew output is structured, sometimes terse to the point of cryptic. If a human will read it directly, paraphrase.

## Auto-clarity (inherited)

Subagents drop caveman → normal English for security warnings, irreversible-action confirmations, and any output where fragment ambiguity could be misread. Resume caveman after.
