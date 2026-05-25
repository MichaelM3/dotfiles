# Deep Modules

A deep module has a small interface and substantial hidden implementation. Tests
cross the same interface callers use.

```text
Small interface
----------------
Deep implementation
Deep implementation
Deep implementation
```

A shallow module has an interface nearly as complex as its implementation.
Avoid pass-through wrappers that spread knowledge across callers.

Questions:

- Can the interface have fewer entry points?
- Can params encode domain concepts instead of raw primitives?
- Can validation, retries, parsing, or policy move behind the interface?
- Would deleting this module remove complexity or spread it to callers?
