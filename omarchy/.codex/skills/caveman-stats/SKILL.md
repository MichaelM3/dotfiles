---
name: caveman-stats
description: Estimate and report token/word savings from Caveman-style compression. Use when the user asks for caveman stats, compression ratio, token savings, brevity metrics, or before/after size comparison.
---

# Caveman Stats

## Purpose

Measure whether compression actually helped. Use approximate local counts unless the project has a tokenizer command available.

## Workflow

1. Identify before and after text or files.
2. Count words, lines, and bytes with local shell tools.
3. If a tokenizer is available in the repo, use it; otherwise label token savings as estimated.
4. Report absolute and percentage reduction.

## Format

```text
before: <words> words, <lines> lines, <bytes> bytes.
after:  <words> words, <lines> lines, <bytes> bytes.
saved:  <percent>% words, <percent>% bytes.
tokens: estimated <percent>% reduction.
```

## Rules

- Do not claim exact token counts without a real tokenizer.
- For code-heavy files, separate prose savings from protected code regions when practical.
- If compression changed protected regions, report failure instead of savings.
