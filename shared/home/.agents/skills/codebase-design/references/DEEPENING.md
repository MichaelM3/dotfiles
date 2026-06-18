# Deepening

Use this when deepening a cluster of shallow modules.

## Dependency Categories

- In-process: pure computation or memory. Merge/deepen and test directly.
- Local-substitutable: local stand-ins exist, such as temp FS, sqlite, PGLite,
  or a test DB. Test with the stand-in; keep seams internal.
- Remote owned: your service across a network. Define a port at the seam;
  production gets HTTP/gRPC/queue adapters, tests get in-memory adapters.
- True external: third-party service. Inject a port; tests use a mock adapter.

## Seam Discipline

- One adapter means a hypothetical seam. Two adapters mean a real seam.
- Do not expose internal seams only because tests use them.
- Keep the external interface small; hide parsing, validation, retries,
  caching, and policy inside the module when they are one responsibility.

## Testing Strategy

- Write tests at the deepened module interface.
- Delete shallow tests once behavior is covered at the new interface.
- Tests assert observable outcomes, not internal state.
- If tests must know the implementation shape, the interface is probably
  wrong.
