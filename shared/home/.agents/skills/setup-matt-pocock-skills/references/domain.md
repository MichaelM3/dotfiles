# Domain Docs

How skills consume project domain docs.

## Read

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`.

Read `.agents/CONTEXT.md` or `.agents/CONTEXT-MAP.md` first when present.
Also read relevant `.agents/adr/` or `.agents/contexts/*/adr/` files. Legacy
root context docs and ADRs are compatibility inputs.

## Use

- Use glossary vocabulary in issue titles, tests, hypotheses, and refactor
  proposals.
- Do not invent synonyms when the glossary gives a canonical term.
- If a needed concept is missing, note it for `grill-with-docs`.
- If output conflicts with an ADR, state the conflict and why it may need
  revisiting.

Missing docs are not an error. Producer skills create them lazily only when
terms or decisions are resolved.
