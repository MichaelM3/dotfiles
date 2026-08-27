---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

Resolve the active `PROJECT_ROOT` before editing. Read project-local `.agents`
domain and tracker context when present; never write project artifacts into the
shared skill installation.

Use /tdd where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use /code-review to review the work.

Commit only when the user requested a commit or the invoking workflow already
received explicit approval to commit.
