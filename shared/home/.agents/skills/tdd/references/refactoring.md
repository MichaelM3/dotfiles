# Refactor Candidates

Refactor only while green.

Look for:

- Duplication behind multiple callers.
- Long methods with separable private steps.
- Shallow modules that should be merged or deepened.
- Feature envy: logic far from the data/concept it belongs to.
- Primitive obsession where a domain value object would clarify rules.
- Newly written code exposing an older awkward interface.

After each refactor step, run the narrow test before moving on.
