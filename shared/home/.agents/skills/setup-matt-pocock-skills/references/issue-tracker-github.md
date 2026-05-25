# Issue Tracker: GitHub

Issues and PRDs live in GitHub Issues. Use the `gh` CLI from `PROJECT_ROOT`.

## Commands

- Create: `gh issue create --title "..." --body-file <file>`
- Read: `gh issue view <number> --comments`
- List: `gh issue list --state open --json number,title,body,labels,comments`
- Comment: `gh issue comment <number> --body-file <file>`
- Label: `gh issue edit <number> --add-label "..." --remove-label "..."`
- Close: `gh issue close <number> --comment "..."`

Infer the repo from `git remote -v`; `gh` normally does this inside a clone.

When a skill says publish to the tracker, create a GitHub issue. When it says
fetch a ticket, read the issue body, labels, and comments.
