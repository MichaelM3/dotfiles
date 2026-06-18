# Design It Twice

Use when the user wants multiple interface options for a chosen deepening
candidate and the active session explicitly allows subagents.

## Process

1. Frame constraints for the user:
   - behavior behind the interface
   - callers
   - dependency category from `DEEPENING.md`
   - invariants, errors, ordering, config, side effects
2. Spawn 3 or more bounded subagents in parallel. Give each a different
   design constraint:
   - minimal surface, 1-3 entry points
   - maximum flexibility
   - common caller optimized
   - ports/adapters where cross-seam dependencies exist
3. Require each output:
   - interface, including invariants and error modes
   - usage example
   - hidden implementation responsibilities
   - dependency strategy and adapters
   - trade-offs in depth, locality, and seam placement
4. Compare designs sequentially, then recommend one option or a hybrid.

If subagents are not allowed, do the same exploration in the main thread with
2-3 options.
