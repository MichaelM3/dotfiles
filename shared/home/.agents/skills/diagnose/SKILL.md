---
name: diagnose
description: Disciplined debugging and performance diagnosis for coding agents. Use when a user reports a bug, failing command, regression, flaky behavior, or asks to diagnose/debug something. Build a feedback loop before fixing.
---

# Diagnose

## Context

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`. Read relevant domain docs and ADRs so hypotheses use project language and respect decisions.

## Loop First

Do not debug by staring. Establish the fastest agent-runnable signal that proves the problem exists:

1. Failing test at the public interface.
2. CLI/HTTP reproduction with fixed input.
3. Browser automation for UI bugs.
4. Captured trace or fixture replay.
5. Throwaway harness around the smallest callable path.
6. Baseline measurement/profiler for performance regressions.
7. Human-in-the-loop script only when automation is impossible.

If no signal exists, create the smallest useful one before changing production code.

## Workflow

1. Reproduce the symptom; capture exact command, input, output, and environment assumptions.
2. Minimize the repro to one behavior.
3. Rank 3-5 falsifiable hypotheses: “If X causes this, changing Y should change Z.”
4. Instrument only decision points that distinguish hypotheses.
5. Tag temp logs with a unique marker like `[DEBUG-7f3a]`.
6. Convert repro into a regression test when project convention supports it.
7. Fix one cause at a time.
8. Re-run minimal repro, original repro, and relevant existing tests.
9. Remove debug artifacts.

## Rules

- Never leave temp logs, harnesses, or snapshots unless asked.
- Do not refactor while repro is red unless needed to observe the bug.
- For flaky failures, raise reproduction rate first: loop, stress, pin time/RNG, record pass/fail counts.
- For performance, measure first: baseline, profiler, query plan, or benchmark.
- If root cause is poor testability, finish the fix, then recommend `architecture`.

## Done

- Original repro no longer reproduces.
- Regression test passes, or missing test seam is documented.
- All `[DEBUG-...]` artifacts are removed.
- Final report states root cause and prevention.
