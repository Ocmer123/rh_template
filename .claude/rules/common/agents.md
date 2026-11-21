# Agents: when to delegate

Agents live in `.claude/agents/`. Use them proactively:

| Situation | Agent |
|---|---|
| New feature or multi-step change, needs a plan | `planner` |
| Folder structure, dependencies between features, new packages | `architect` |
| Domain logic, parsers, notifiers | `tdd-guide` (tests first), then implement |
| Screens, widgets, theme, animation | `flutter-ui-engineer` |
| After writing code, before a PR | `code-reviewer` (always) |
| Networking, storage, auth, permissions, `.github/`, before a release | `security-reviewer` |
| Accessibility, text scaling, motion | `a11y-reviewer` |
| `flutter analyze`, build or test failures | `build-error-resolver` |
| Dead code, duplication, oversized files | `refactor-cleaner` |
| Docs, CHANGELOG or ADRs out of date | `doc-updater` |

- Independent work runs in parallel agents, each on its own branch or worktree.
- Give an agent the plan file and the exact acceptance criteria, not the whole conversation.
- An agent's output is not done until `/verify` passes.
