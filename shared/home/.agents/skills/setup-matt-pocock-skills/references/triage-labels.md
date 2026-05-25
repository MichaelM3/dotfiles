# Triage Labels

Map canonical triage roles to the actual labels or states used by the tracker.

| Role | Tracker label/state | Meaning |
| --- | --- | --- |
| `needs-triage` | `needs-triage` | Maintainer needs to evaluate |
| `needs-info` | `needs-info` | Waiting on reporter/user detail |
| `ready-for-agent` | `ready-for-agent` | Fully specified, AFK-agent ready |
| `ready-for-human` | `ready-for-human` | Requires human implementation |
| `wontfix` | `wontfix` | Will not be actioned |

Every triaged issue should have exactly one category role (`bug` or
`enhancement`) and one state role. If labels conflict, stop and ask.
