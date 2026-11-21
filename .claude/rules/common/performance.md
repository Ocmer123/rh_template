# Performance

- Use `const` constructors wherever you can (the lint is on).
- Use `ListView.builder` or slivers for lists. Avoid `shrinkWrap: true` on long lists.
- Use `select` in providers so that only the widget that depends on a value rebuilds.
- Wrap expensive, independently animating subtrees in a `RepaintBoundary`. Never animate blur.
- Compute elapsed time from wall-clock timestamps, not by counting ticks.
- Load and parse assets once, through a cached provider. Cache network results with an explicit lifetime.
- Keep heavy work (large JSON, image processing) off the UI isolate with `compute` / `Isolate.run`.
- Check frame times in profile mode (`flutter run --profile`) before optimising; do not guess.
- **Context hygiene for Claude:** read the relevant feature folder, plan and rule, not the whole repo. Delegate broad searches to an agent.
