# CONTEXT.md Format

```markdown
# <Context Name>

One or two sentences describing this domain context.

## Language

**Order**:
One or two sentences defining the term.
_Avoid_: Purchase, transaction

**Customer**:
A person or organization that places orders.
_Avoid_: Client, buyer, account

## Flagged Ambiguities

- **Account**: sometimes means Customer, sometimes User. Use Customer for the
  buyer organization and User for the signed-in person.

## Example Dialogue

Dev: Can a Customer have many Orders?
Domain expert: Yes. An Order belongs to exactly one Customer.
```

## Rules

- Pick one canonical term when synonyms exist.
- Keep definitions tight: one or two sentences.
- Define what the term is, not implementation behavior.
- Include only domain concepts specific to this project.
- Show relationships and cardinality when obvious.
- Group terms under subheadings only when it improves scanning.
- Revise stale definitions in place as understanding improves.
