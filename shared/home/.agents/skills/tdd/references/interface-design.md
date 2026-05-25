# Interface Design For Testability

Good interfaces make tests natural.

## Accept Dependencies

```typescript
function processOrder(order, paymentGateway) {}
```

Avoid constructing external dependencies inside behavior under test.

## Return Results

Prefer results or events that callers can observe. Minimize hidden mutation.

```typescript
function calculateDiscount(cart): Discount {}
```

## Keep Surface Small

Small public surfaces need fewer tests and can hide more behavior. If tests need
many setup facts, the interface may be too wide or too shallow.
