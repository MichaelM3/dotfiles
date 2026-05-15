---
name: pr-summary
description: >-
  Opens a GitHub pull request for the current branch using gh, after verifying commits exist on the remote. Merge base defaults to dev; optional argument sets merge base (e.g. bugfix/test). Never uses main or stage as merge base. If an open PR already exists for the head branch, updates the PR body (and optional title) instead of creating. Produces a concise PR title and body. Use only when the user invokes pr-summary, /pr-summary, or explicitly asks to draft or open a PR this way.
---

# PR summary (GitHub)

Manual skill—do not auto-load from ambient context.

## How to invoke (merge base)

PR **merge base** = GitHub `--base` (branch you open the PR **into**). Head = **current local branch** (unchanged).

| User says | Merge base (`gh pr create --base`) |
|-----------|-------------------------------------|
| `/pr-summary` | **`dev`** |
| `/pr-summary bugfix/test` | **`bugfix/test`** |
| `@pr-summary` + rest of line | **Rest** after skill name (trimmed). Same rules as `/pr-summary …`. |

Treat **`/pr summary …`** / **`pr-summary …`** the same: optional remainder of line after command = merge base.

**Forbidden merge bases (never use):** `main`, `stage` — case-insensitive match on branch name (trim whitespace). If user asks for either: **stop**, refuse `gh pr create`, explain once: choose `dev`, another feature branch, or allowed release line—**not** `main` or `stage`.

**Parsing (`BASE`) for agent:** Strip `@pr-summary`, `/pr-summary`, or `/pr summary` from the user message; take **rest of line**, trim. Empty → `BASE=dev`. Non-empty → `BASE` = that string (branch names may include `/`, e.g. `bugfix/test`). For veto only: compare lower-case `BASE` to `main` / `stage`. Pass **original trimmed spelling** to `gh pr create --base` and `git fetch` (GitHub branch casing).

## Goal

Open a new PR for **current local branch** with a **short, high-signal** description, **or** if that branch already has an open PR, **refresh the description** (same template). Avoid walls of text, exhaustive file lists, and implementation trivia. Lead with **user-visible outcomes**: bugfixes, behavior changes, new capability—then **where** it lives (modules/services), not every edited path.

## Tools

| Need | Use |
|------|-----|
| Push branch, check state | `git` |
| Create or update PR on GitHub | `gh` (`gh pr list`, `gh pr create`, `gh pr edit`) |

Git alone cannot open a PR; use **`gh`** to create it. Do not fabricate a PR URL.

**`gh` in agent/sandbox shells:** `gh auth status` or `gh pr create` may error here (no network, sandbox token visibility) while **user’s own terminal is already logged in**. Do **not** conclude “must run `gh auth login`” from a failed check alone.

If `gh` fails:

1. Run `gh pr create` (and `gh pr edit`, `gh pr list`, `gh repo view` if needed) with **network enabled** for the command (`full_network` / outside sandbox when applicable).
2. Still failing → ask user run the same `gh pr …` command locally and paste URL—or fix only when message clearly says token expired / not authenticated.
3. Binary missing → point to GitHub CLI install docs.

Assume user is authenticated unless they say otherwise or `gh` returns an explicit auth error after a **network-capable** attempt.

## Preconditions (stop and message user if fail)

Run from repo root.

1. **Uncommitted or unstaged work**  
   - `git status --short`  
   - If anything shows (modified/untracked user cares to ship): **do not open PR yet.**  
   - Tell user: commit (and push) intended work first—PR should reflect committed delta, not dirty tree.

2. **Branch not on remote or not pushed**  
   - `git branch --show-current` → `BRANCH`  
   - Upstream: `git rev-parse --abbrev-ref @{u} 2>/dev/null` or check `git status -sb` for tracking.  
   - Remote head: `git ls-remote --heads origin "$BRANCH"`  
   - If no commits on remote for this branch, or local is **ahead** of `@{u}`: user must **`git push -u origin HEAD`** (or push upstream) before `gh pr create` **or** `gh pr edit` (GitHub must see head).
   - Remind clearly; run push **only if** user asked to push or session rules allow—otherwise instruct command.

3. **Merge base (`BASE`)**  
   - From [How to invoke](#how-to-invoke-merge-base): default **`dev`** if user gave no branch argument.  
   - Validate: if normalized lower-case `BASE` is `main` or `stage` → **abort** (forbidden list).  
   - Before `git log` / `git diff` vs base: `git fetch origin "<BASE>"` (network) when needed so `origin/<BASE>` exists.

When blocked, output **one short checklist**: commit → push → re-run skill.

## Draft PR content (before gh)

Gather **high-level** facts only:

- `git log origin/<BASE>..HEAD --oneline` for themes—not every SHA.
- Optional: `git diff origin/<BASE>...HEAD --stat` for scope—use **areas** (e.g. `api/routes/appointments`, `app/settings`), not 40 filenames.

**Tone:** professional GitHub PR—complete sentences in description; concise sections; no emoji unless project already uses them.

### Title

- One line, imperative, ≤ ~72 chars if possible.  
- Like good commit subject: **what** changes for reviewers (e.g. `Fix availability cache key when resource pool empty`).

### Body template (fill; omit empty sections)

Use this structure—keep each section **brief**:

```markdown
## Summary

[2–4 sentences: problem or goal, what changed at product/API level, why it matters. No dump of implementation steps.]

## Areas touched

[Bullets: domains or layers—e.g. `GET /v3/availability` handler, Redis cache invalidation, `app` schedule editor—not a full file tree.]

## How to test

[Numbered or bulleted, concrete steps: env, seed data if needed, URLs or commands, expected result.]

## Notes

[Optional: feature flags, migrations, follow-ups, risk—not essays.]
```

**Explicit anti-patterns for body:**

- Copy-paste of entire diff or long stack traces  
- Bullet list of every touched file  
- AI filler (“comprehensive overhaul”, “leverages”)  
- Duplicating commit messages verbatim for every commit  

## Create or update PR

After title + body are agreed (or user says proceed), **`HEAD_BRANCH`** = `git branch --show-current`.

### 1. Detect existing open PR

Use **network-capable** `gh`:

```bash
gh pr list --head "$HEAD_BRANCH" --state open --json number,url,baseRefName
```

- **0 open PRs:** go to **Create** below.
- **1+ open PRs:** go to **Update** below (never fail just because a PR already exists).

If **multiple** open PRs share the same head (rare): prefer the PR whose `baseRefName` equals **`BASE`** (case-sensitive match to GitHub’s value); else use the **first** list entry and mention ambiguity in output.

### 2. Update (existing)

Refresh description—do **not** change merge base unless user explicitly asked (optional `gh pr edit -B` not part of default skill).

```bash
gh pr edit <number> --body-file <path> [--title "<title>"]
```

Always pass **`--body-file`**. Include **`--title`** when a new title was drafted and it improves clarity (same rules as create).

**Note:** If existing PR’s base is not **`BASE`**, still update body/title; state in output: PR merges into `actual-base`, requested **`BASE`** was for **new** PRs only—user can retarget manually if wrong.

### 3. Create (none yet)

```bash
gh pr create --base <BASE> --head "$HEAD_BRANCH" --title "<title>" --body-file <path>
```

`<BASE>` = resolved merge base (`dev` by default, or user-supplied branch name). Never `--base main` or `--base stage`.

### 4. Create failed with “already exists” / HTTP conflict

Re-run **Detect** (`gh pr list --head`) and follow **Update**. Do not surface raw error as final failure without attempting edit.

Optional multiline body: prefer **`--body-file`**; short bodies may use **`--body`**. Optional **`gh pr create`** flags when user asks: `--draft`, `--reviewer`, `--label`. For **`gh pr edit`**, see `--title`, `--body-file`, labels/reviewers in `gh pr edit --help`. Avoid bare `gh pr create` that drops into interactive editor unless user wants that.

## Output to user

- PR URL from `gh` stdout (`pr create` or `pr edit` prints URL / confirmation).  
- Say whether action was **created** or **updated** description.  
- State merge **`BASE`** used for **create**; for **update**, state PR number + actual base if relevant.  
- If draft: say so (create path).  
- One-line recap what reviewers should focus on.

## Boundaries

- Does not replace CI, code review, or Changesets/versioning—only PR creation **or** description/title refresh on existing PR.  
- OnSched release checklist still applies when behavior/docs/OpenAPI change—see **onsched-agent-handoff** / **onsched-versioning** as appropriate.
