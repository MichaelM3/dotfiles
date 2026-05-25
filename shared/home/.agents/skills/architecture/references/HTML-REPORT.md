# HTML Report

Architecture review artifacts go in the OS temp directory, never the repo.

## Path

Use `$TMPDIR` or `/tmp` on Unix, `%TEMP%` on Windows:

```text
architecture-review-<timestamp>.html
```

## Content

- Repo name and date.
- Legend: module, seam, leakage, deep module.
- Candidate cards:
  - Files/modules involved.
  - Problem.
  - Solution.
  - Benefits in terms of leverage and locality.
  - Before/after diagram.
  - Recommendation: `Strong`, `Worth exploring`, or `Speculative`.
  - ADR conflict callout when relevant.
- Top recommendation.

Use Tailwind/Mermaid CDNs only when acceptable. Otherwise use static HTML/CSS.
Keep prose terse; diagrams should carry the explanation.
