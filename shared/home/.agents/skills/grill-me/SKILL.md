---
name: grill-me
description: Run a pure interview that stress-tests a plan or design until each decision branch is resolved. Use when the user says grill me, asks to be challenged on a plan, or wants questions before implementation without writing project docs.
---

# Grill Me

Interview the user until the plan is precise. Ask one question at a time.
Provide your recommended answer with each question.

## Before Questions

If the prompt concerns a repo, inspect enough local context first:

- `AGENTS.md`, README, package manifests, project docs.
- Adjacent code, tests, and existing patterns.
- Existing issue/PRD text if referenced.

If code answers a question, answer it from code instead of asking.

## Question Order

Walk dependencies in order:

1. User outcome.
2. Domain concepts and vocabulary.
3. Current system behavior.
4. State, data, and lifecycle.
5. Failure modes and edge cases.
6. Permissions, privacy, and security.
7. Rollout and migration.
8. Testing and verification.

Do not write docs or code unless the user asks.
