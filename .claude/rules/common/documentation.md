# Documentation

Docs live next to the code and change in the same PR as the code they describe.

| What changed | Update |
|---|---|
| Anything user-visible | A line under *Unreleased* in `CHANGELOG.md` (Keep a Changelog groups: Added, Changed, Fixed, Removed, Security) |
| Structure, data flow, a new feature folder | `docs/architecture/overview.md` |
| A choice someone could reasonably question | A new ADR: copy `docs/decisions/template.md` to the next number |
| Work that takes more than one PR | A plan in `docs/plans/` (copy `template.md`) with checkboxes you tick as you go |
| Pipelines, branch rules, secrets | `docs/architecture/ci-cd.md` |
| Setup or commands | `README.md` and `CONTRIBUTING.md` |

- After adding or renaming a doc, run `python tool/docs_index.py`. CI fails when the index in `docs/README.md` is stale.
- Relative links must resolve and Markdown must lint clean; both are checked in CI.
- Write plainly: short sentences, concrete examples, no marketing language.
- ADRs are never edited after they are accepted. To change a decision, write a new ADR and mark the old one `Superseded by NNNN`.
