# ADR Format

ADRs live under `.agents/adr/` for repo-wide decisions or
`.agents/contexts/<context-slug>/adr/` for context-specific decisions.

Create the ADR directory lazily. Files use sequential numbering:
`0001-slug.md`, `0002-slug.md`.

## Template

```markdown
# <Short Decision Title>

One to three sentences: context, decision, and why.
```

Optional sections are allowed only when they add value:

- `Status:` frontmatter or line: `proposed`, `accepted`, `deprecated`, or
  `superseded by ADR-NNNN`.
- `## Considered Options`
- `## Consequences`

## Offer An ADR Only When

- The decision is hard to reverse.
- Future readers would be surprised without context.
- There were real alternatives and a trade-off.
