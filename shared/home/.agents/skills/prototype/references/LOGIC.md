# Logic Prototype

Use for business logic, state transitions, data shape, or API-feel questions.

## Shape

Build a small interactive terminal app or script. Keep the real logic in a
portable pure module; the terminal shell is throwaway.

Good core shapes:

- Reducer: `(state, action) => state`.
- Explicit state machine.
- Pure functions over plain data.
- Small class/module with clear method surface when it truly owns state.

## Process

1. State the question in a README, `NOTES.md`, or top-of-file comment.
2. Use the repo's existing runtime and task runner.
3. Render current state after every action.
4. List keyboard shortcuts or commands in the UI.
5. Provide one command to run it.
6. Capture the answer before deleting or folding it into production code.

## Avoid

- Tests.
- Real DB writes unless persistence is the question.
- Generalizing beyond the single question.
- Mixing terminal I/O into the portable logic module.
