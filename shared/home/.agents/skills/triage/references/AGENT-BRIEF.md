# Agent Brief

An agent brief is the contract for work moving to `ready-for-agent`. It should
be durable if files move or code changes.

## Principles

- Describe behavior and interfaces, not line numbers.
- Include acceptance criteria that can be verified independently.
- State explicit out-of-scope boundaries.
- Include enough context that an AFK agent does not need chat history.

## Template

```markdown
## Agent Brief

**Category:** bug | enhancement
**Summary:** one-line description

**Current behavior:**

**Desired behavior:**

**Key interfaces:**
- `TypeOrInterface` - what needs to change and why

**Acceptance criteria:**
- [ ] Specific criterion
- [ ] Specific criterion

**Out of scope:**
- Adjacent work not included

**Verification:**
- Command or manual check
```

Avoid stale file paths unless they are stable public entry points. Never use
line numbers as implementation instructions.
