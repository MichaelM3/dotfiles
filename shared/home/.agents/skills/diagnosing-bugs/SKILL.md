---
name: diagnosing-bugs
description: Disciplined bug and performance diagnosis. Use when the user says diagnose/debug, reports broken behavior, failing checks, regressions, flakes, or slowness.
---

# Diagnosing Bugs

Build a tight feedback loop before theorizing.

## Context

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`. Read
relevant domain docs and ADRs so hypotheses use project language and respect
decisions.

## Phase 1: Feedback Loop

Establish the fastest agent-runnable signal that can go red on this exact bug:

1. failing test at the public interface
2. CLI/HTTP reproduction with fixed input
3. browser automation for UI bugs
4. captured trace or fixture replay
5. throwaway harness around the smallest callable path
6. property/fuzz loop for inconsistent outputs
7. baseline measurement or profiler for performance regressions
8. human-in-the-loop script only when automation is impossible

Tighten the loop: faster, sharper assertion, more deterministic. For flakes,
raise reproduction rate first: loop, stress, pin time/RNG, record counts.

If no loop is possible, stop and ask for access, captured artifacts, or
permission for temporary instrumentation. Do not hypothesize without a loop.

## Workflow

1. Reproduce the symptom; capture exact command, input, output, and environment
   assumptions.
2. Minimize the repro to one behavior.
3. Rank 3-5 falsifiable hypotheses:
   `If X causes this, changing Y should change Z`.
4. Instrument only decision points that distinguish hypotheses.
5. Tag temp logs with a unique marker like `[DEBUG-7f3a]`.
6. Convert repro into a regression test when a correct seam exists.
7. Fix one cause at a time.
8. Re-run minimal repro, original repro, and relevant existing tests.
9. Remove debug artifacts.

## Rules

- Do not refactor while the repro is red unless needed to observe the bug.
- Never leave temp logs, harnesses, snapshots, or probes unless asked.
- For performance, measure first: baseline, profiler, query plan, or benchmark.
- If no correct test seam exists, document that and recommend `architecture`
  after the fix.

## Done

- Original repro no longer reproduces.
- Regression test passes, or missing test seam is documented.
- All `[DEBUG-...]` artifacts are removed.
- Final report states root cause and prevention.
