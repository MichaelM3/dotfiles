# Mocking

Mock only at system boundaries:

- External APIs.
- Time and randomness.
- Filesystem, when a real temp directory is not practical.
- Databases, only when a test DB or local substitute is too expensive.

Do not mock internal modules you control. Prefer exercising real collaborators
through the public interface.

## Boundary Interfaces

Accept dependencies instead of constructing them internally.

```typescript
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}
```

Prefer specific SDK-style operations over generic fetchers. Specific operations
make tests clear and mocks simple.
