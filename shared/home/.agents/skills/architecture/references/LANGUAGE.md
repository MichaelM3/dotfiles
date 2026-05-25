# Architecture Language

Use these terms consistently.

**Module**:
Anything with an interface and implementation: function, class, package, or
slice. Avoid component, service, or unit when module is meant.

**Interface**:
Everything callers must know: types, invariants, ordering, errors, config,
side effects, and performance expectations. Broader than a type signature.

**Implementation**:
The code behind the interface.

**Depth**:
Leverage at the interface. A deep module exposes a small interface with
substantial behavior behind it. A shallow module exposes an interface nearly as
complex as its implementation.

**Seam**:
Place where behavior can vary without editing callers.

**Adapter**:
Concrete implementation satisfying an interface at a seam.

**Leverage**:
Capability callers get per unit of interface they learn.

**Locality**:
Change, bugs, knowledge, and verification concentrated in one module.

## Principles

- Depth is a property of the interface, not implementation line count.
- Deletion test: if deleting a module removes complexity, it was pass-through;
  if complexity spreads to callers, it was earning its keep.
- The interface is the test surface.
- One adapter is a hypothetical seam; two adapters justify a real seam.
