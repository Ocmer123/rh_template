# Architecture Decision Records

An ADR records one decision: the context, the options and the consequences. Write one whenever someone could reasonably ask "why did we do it this way?".

- Copy [template.md](template.md) to the next free number: `NNNN-short-title.md`.
- Start with `Status: Proposed`. The owner sets it to `Accepted`.
- Never edit an accepted ADR. To change a decision, write a new ADR and set the old one to `Superseded by NNNN`.
- Run `python tool/docs_index.py` so the record shows up in the [docs index](../README.md).
