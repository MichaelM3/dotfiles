# Good And Bad Tests

Good tests verify behavior through public interfaces. They describe what the
system does and survive internal refactors.

```typescript
test("user can checkout with a valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

Bad tests couple to implementation details.

```typescript
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

Red flags:

- Mocking internal collaborators.
- Testing private methods.
- Asserting incidental call counts/order.
- Verifying storage directly when a public read interface exists.
- Test name describes how, not what.
