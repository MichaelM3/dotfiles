# Interface Design

Use when the user chooses a deepening candidate and wants alternative
interfaces.

## Process

1. Frame constraints:
   - What behavior sits behind the interface.
   - Which callers use it.
   - Dependency category from `DEEPENING.md`.
   - Required invariants, errors, ordering, and config.
2. Draft at least two meaningfully different interfaces.
3. Compare by depth, locality, seam placement, and test surface.
4. Recommend one option or a hybrid.

If the active harness supports subagents and policy/user permission allows it,
parallelize interface drafts. Give each worker a different design constraint:
minimal surface, flexible extension, common caller optimized, or ports/adapters.
