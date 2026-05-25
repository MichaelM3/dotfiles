# Deepening

Classify dependencies before proposing a deeper module.

## Dependency Categories

- In-process: pure computation or memory. Merge/deepen and test directly.
- Local-substitutable: local stand-ins exist, such as temp FS or test DB.
- Remote owned: own service across network. Define a port at the seam; use
  production and in-memory adapters.
- True external: third-party dependency. Inject a port; tests use a mock
  adapter.

## Testing

- Write tests at the deepened module interface.
- Delete old shallow tests once behavior is covered at the new interface.
- Do not expose internal seams only for tests.
- Tests assert observable outcomes, not internal state.
