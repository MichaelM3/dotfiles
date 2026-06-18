# Glossary: Building Great Skills

## Language

**Predictability**:
The agent behaves the same way every run: same process, not same output.
_Avoid_: output determinism

**Model-invoked**:
A skill with a `description` visible to the agent, so it can fire
autonomously and other skills can point at it.

**User-invoked**:
A skill with `disable-model-invocation: true`, intended to be reached only when
the user types it.

**Description**:
The model-facing context pointer that says when to invoke a skill.

**Context pointer**:
Text in context that names out-of-context material and encodes when to load it.

**Context load**:
The permanent token and attention cost of visible model-invoked descriptions.

**Cognitive load**:
The human memory cost of user-invoked skills.

**Router skill**:
A user-invoked skill that helps the human choose among other skills.

**Information hierarchy**:
The ordering of skill material by immediacy: steps, in-skill reference, then
external reference.

**Progressive disclosure**:
Moving branch-only or long reference behind a context pointer.

**Completion criterion**:
The condition that proves a step is actually done.

**Leading word**:
A compact term the model already knows that anchors behavior and invocation.

**Single source of truth**:
One authoritative home for each meaning.

## Failure Modes

**Premature completion**:
Ending a step before its completion criterion is met.

**Duplication**:
Repeating one meaning in multiple places.

**Sediment**:
Stale content left behind because adding felt safer than removing.

**Sprawl**:
A skill whose live content is too long for the top-level file.

**No-op**:
An instruction that does not change behavior versus the default.
