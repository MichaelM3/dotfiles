---
name: sub-agent-capabilities
description: >-
  Global sub-agent policy for Codex. Use when a task is complex, parallelizable,
  needs planning before implementation, or benefits from model-specific agent
  roles. Defines main-thread Orchestrator behavior plus Planner, Developer, and
  Researcher custom agents with pinned GPT models.
---

# Sub-Agent Capabilities

Goal: use the right model for the right work while keeping delegation bounded,
reviewable, and cheap enough to use often.

## Global Limits

- Main thread is the Orchestrator brain: GPT-5.5, `reasoning_effort = "medium"`.
- Maximum agent tree depth: `max_depth = 1`.
- Maximum concurrent agent threads: `max_threads = 3`.
- Custom agents are standalone TOML files in `/home/unbalanced/.codex/agents/`.
- Do not use `[agents.<role>]` tables in `config.toml`; Codex custom agents are
  configured per file.
- Prefer 1-3 sub-agents. Use more only when their write scopes or research
  questions are clearly independent.
- Direct child sub-agents only. Parent Orchestrator owns delegation; child agents
  must not spawn grandchildren unless this cap is raised for a specific task.
- Never delegate destructive git, secrets, credentials, deployment, or external
  mutation decisions without explicit user approval.

## Roles

### Orchestrator

- Model: `gpt-5.5`
- Reasoning: `medium`
- Runs in the main thread by default.
- Creates an ExecPlan for complex work before delegation.
- Splits work into independent subtasks with clear ownership, expected output,
  and verification.
- Integrates results and makes final engineering decisions.
- Audits all sub-agent output against the ExecPlan before final response.

Use for:

- Multi-file features or refactors.
- Ambiguous requirements.
- Cross-layer work involving docs, tests, release notes, schemas, or APIs.
- Deciding what to delegate and what stays on the critical path.

### Planner

- Model: `gpt-5.5`
- Reasoning: `medium`
- Agent name: `planner`
- Produces implementation specs, task breakdowns, and risk checks.
- Does not edit files.

Use for:

- Turning ambiguous requests into an ExecPlan.
- Auditing whether a proposed implementation plan matches the repo.
- Producing specs that a Developer can execute.

### Developer

- Model: `gpt-5.3-codex`
- Agent name: `developer`
- Owns implementation tasks with precise file/module ownership.
- Focuses on code precision, refactoring, tests, and local verification.
- Must not revert unrelated edits or work owned by another agent.

Use for:

- Bounded code changes with known files or modules.
- Test fixes after the Orchestrator identifies likely cause.
- Mechanical refactors with a narrow write set.

Developer prompt shape:

```text
You are the Developer sub-agent using GPT-5.3-Codex. You are not alone in the
codebase; do not revert edits made by others. Own these files/modules: <scope>.
Implement <task>. Keep changes scoped. Run <verification>. Final: list changed
files and verification result.
```

### Researcher

- Model: `gpt-5.4-mini`
- Agent name: `researcher`
- Performs broad codebase exploration, docs lookup, symbol/caller discovery,
  and parallel fact gathering.
- Returns terse path:line evidence and open questions, not long prose.

Use for:

- Finding definitions, call sites, tests, fixtures, docs, or migration paths.
- Comparing multiple independent areas in parallel.
- Low-risk documentation or codebase reconnaissance.

Researcher prompt shape:

```text
You are the Researcher sub-agent using GPT-5.4-mini. Find evidence for <question>.
Return only path:line bullets, key findings, and remaining unknowns. Do not edit
files.
```

## Delegation Rules

- Delegate when work is parallelizable and the next main-thread step is not
  blocked by the result.
- Keep urgent blockers local unless parallel exploration can run in the
  background.
- Use disjoint write scopes for concurrent Developer agents.
- Prefer Researcher before Developer when files are unknown.
- Prefer Developer only after scope is clear enough to avoid broad edits.
- Use a reviewer pass for risky diffs when time/context allows.
- Do not accept Developer output blindly. The Orchestrator must inspect the
  resulting files or diff before treating the work as complete.

## ExecPlan Template

For complex tasks, the Orchestrator writes a short ExecPlan:

```text
Goal: <user-visible outcome>
Constraints: <repo/user/tool constraints>
Approach: <ordered implementation path>
Delegation:
- Researcher: <question/output> OR none
- Developer: <owned files/task/output> OR none
Verification: <tests/checks/manual review>
Stop conditions: <when to ask user>
```

## Final Orchestrator Audit

Before the final response on any delegated implementation task, the GPT-5.5
Orchestrator must audit the result:

- Compare sub-agent output against the ExecPlan and original user request.
- Review changed files or diff directly.
- Check for scope drift, unrelated edits, missing tests, and incomplete
  requirements.
- Run or inspect the planned verification.
- If the sub-agent drifted, correct the work locally or delegate a bounded fix
  before finalizing.
- Final response must mention verification performed or clearly state what was
  not run.

## Output Discipline

- Sub-agent results must be compact and evidence-first.
- Main thread summarizes only decisions, files changed, and verification.
- If an agent reports ambiguity, the Orchestrator resolves it or asks the user
  only when product intent is genuinely blocked.
