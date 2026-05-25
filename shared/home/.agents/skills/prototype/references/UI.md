# UI Prototype

Use for visual/product layout questions.

## Shape

Prefer variants inside an existing route using `?variant=`. Create a new
throwaway route only when there is no natural host page.

Default to three variants, max five. Variants must differ structurally:
layout, information hierarchy, primary action, or interaction model. Color/copy
changes are not enough.

## Switcher

Provide a small floating switcher:

- Previous/next controls.
- Current variant label.
- URL param updates so reload/share works.
- Keyboard left/right when focus is not in an input.
- Hidden in production builds if the code could be merged accidentally.

## Process

1. State the question and variant plan in one line.
2. Keep existing data fetching/auth/params when using an existing route.
3. Build distinct variant components.
4. Hand over URL and variant keys.
5. Capture which variant won and why.
6. Delete losing variants and switcher, or promote the winner properly.
