---
name: diagnose
description: Disciplined debugging and performance diagnosis for coding agents. Use when a user reports a bug, failing command, regression, flaky behavior, or asks to diagnose/debug something. Build a feedback loop before fixing.
---

# Diagnose

## Project Context

Before tracing code, follow
`/home/unbalanced/.agents/instructions/project-artifacts.md`. Read relevant
`.agents` domain docs, ADRs, and legacy compatibility docs so hypotheses use
the project's language and respect recorded decisions.

## Loop First

Do not debug by staring. The feedback loop is the work. Establish the fastest
agent-runnable signal that proves the problem exists:

1. Failing test at the public interface.
2. CLI or HTTP reproduction with fixed input.
3. Browser automation for UI bugs.
4. Captured trace or fixture replay.
5. Throwaway harness around the smallest callable path.
6. Baseline measurement/profiler for performance regressions.
7. Human-in-the-loop script only when no automation is possible.

Iterate on the loop itself: make it faster, sharper, and more deterministic.
If no signal exists, make that explicit and create the smallest useful one
before changing production code.

## Workflow

1. Reproduce the original symptom and capture exact command, input, output, and environment assumptions.
2. Minimize the repro until it isolates one behavior.
3. Rank 3-5 falsifiable hypotheses by likelihood and cheapness to falsify.
   Format each as: "If X is the cause, changing Y should change Z." Share the
   ranked list when the user is actively collaborating; proceed if they are AFK.
4. Instrument only at decision points that distinguish hypotheses. Prefer debugger/REPL/profiler over broad logging.
5. Tag temporary logs with a unique marker such as `[DEBUG-7f3a]` so cleanup is grepable.
6. Convert the minimal repro into a regression test where the project convention supports it.
7. Fix one cause at a time.
8. Re-run the minimal repro, the original repro, and the relevant existing test suite.
9. Remove debug artifacts and report what would have prevented the bug.

## Rules

- Never leave temporary logs, harnesses, or snapshots unless the user asks to keep them.
- Do not refactor while the repro is still red unless the refactor is required to observe the bug.
- For nondeterministic failures, raise reproduction rate first: loop 100x,
  parallelize, add stress, pin time/RNG, inject sleeps, and record pass/fail
  counts before declaring success.
- For performance regressions, measure first: baseline timing, profiler, query
  plan, or benchmark harness before fixing.
- If the root cause is poor testability or tangled ownership, finish the fix first, then recommend `architecture`.

## Post-Mortem

Before declaring done:

- Original repro no longer reproduces.
- Regression test passes, or missing test seam is documented.
- All `[DEBUG-...]` artifacts are removed.
- Correct hypothesis and prevention are stated in the final report.
