# Issue Tracker: GitLab

Issues and PRDs live in GitLab Issues. Use the `glab` CLI from `PROJECT_ROOT`.

## Commands

- Create: `glab issue create --title "..." --description "..."`
- Read: `glab issue view <number> --comments`
- List: `glab issue list -F json`
- Comment: `glab issue note <number> --message "..."`
- Label: `glab issue update <number> --label "..." --unlabel "..."`
- Close: post a note first, then `glab issue close <number>`

GitLab calls pull requests merge requests. Use `glab mr ...` only when the
workflow explicitly touches merge requests.

When a skill says publish to the tracker, create a GitLab issue. When it says
fetch a ticket, read the issue body, labels, and comments.
