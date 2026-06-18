---
name: thermo-nuclear-code-quality-review
description: Extremely strict maintainability review for code judo, 1k-line threshold, spaghetti branching, abstraction and boundary health. Use when the user asks for thermo nuclear, thermo-nuclear, thermonuclear, nuclear, Cursor team, or especially harsh code quality review.
---

# Thermo-Nuclear Code Quality Review

Source: `https://github.com/cursor/plugins/blob/main/cursor-team-kit/skills/thermo-nuclear-code-quality-review/SKILL.md`.

Use for unusually strict review of implementation quality, maintainability,
abstraction quality, and codebase health. Default scope: current branch diff
against the repo default branch or user-supplied diff/paths. Review only unless
the user explicitly asks for fixes.

## Setup

1. Read repo instructions and relevant domain docs before judging structure.
2. Inspect `git diff --stat`, `git diff`, changed file contents, callers, and tests.
3. If no diff exists, review the paths or design the user names; otherwise ask for scope.
4. Ground each finding in concrete files/lines and observed code, not taste.

## Approval Bar

Do not approve merely because behavior works. Approval requires:

- No clear structural regression.
- No visible code-judo simplification left unused.
- No unjustified file-size explosion, especially crossing ~1000 lines.
- No special-case spaghetti added to already busy flows.
- No hacky, magical, wrapper-heavy, cast-heavy, or optionality-heavy contracts.
- No architecture-boundary leak, wrong layer, or duplicate bespoke helper.

Treat these as presumptive blockers until justified.

## Questions

- Can a code-judo move delete whole branches, helpers, modes, or layers?
- Can the model be reframed so fewer concepts or conditionals exist?
- Did local architecture, cohesion, coupling, or scanability get worse?
- Did branching grow where a state model, helper, or abstraction belongs?
- Is logic in the right file, package, service, and layer?
- Did size cross a healthy boundary, especially ~1000 lines?
- Does each abstraction earn its keep, or is it pass-through indirection?
- Did casts, `any`, `unknown`, optional params, or ad-hoc shapes hide invariants?
- Could orchestration be simpler, more parallel, or more atomic?

## Blockers

- Complex implementation where a cleaner reframing could delete complexity.
- Refactor that moves complexity but does not reduce concepts.
- File crossing ~1000 lines because of the change.
- New conditionals bolted into unrelated paths.
- One-off booleans, nullable modes, feature flags, or temporary branches likely to stay.
- Feature logic leaking into shared/general-purpose modules.
- Generic magic hiding simple data-shape assumptions.
- Thin wrappers, pass-through helpers, copy-paste, or unnecessary abstraction layers.
- Cast-heavy or optionality-heavy contracts where explicit typed boundaries fit.
- Edge-case logic inserted into already busy functions.
- Sequential async flow or partial updates that make state harder to reason about.

## Remedy Bias

- Delete a layer rather than polish it.
- Reframe state so conditionals disappear.
- Move ownership so the feature becomes natural to an existing abstraction.
- Turn special cases into a simpler default flow.
- Extract focused helpers, pure functions, subcomponents, or modules.
- Split large files before normalizing sprawl.
- Replace condition chains with typed models or explicit dispatch.
- Separate orchestration from business logic; parallelize when it simplifies.
- Collapse duplicate branches; delete wrappers that do not clarify APIs.
- Reuse canonical helpers; move logic to the canonical package/module/layer.
- Make type boundaries explicit and related updates atomic.

## Output

Findings first, ordered by severity and this priority:

1. Structural regressions.
2. Missed dramatic simplification / code-judo move.
3. Spaghetti or branching-complexity growth.
4. Boundary, abstraction, or type-contract problems.
5. File-size and decomposition concerns.
6. Modularity and canonical-layer issues.
7. Legibility and maintainability concerns.

Use `path:line: severity: problem. fix.` when possible. Be direct, serious,
and demanding. No praise padding. Skip cosmetic nits while structural issues
exist. Prefer few high-conviction findings over many low-value comments. If no
issues: state approval explicitly, then name residual risks or tests not run.
