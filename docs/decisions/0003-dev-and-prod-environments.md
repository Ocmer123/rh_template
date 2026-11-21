# 0003 Dev and prod environments tied to branches

Status: Accepted
Date: 2026-11-21

## Context

Testers need builds of the latest integrated work, while production builds must never contain debug tools or be confused with test builds. Signing secrets must only be reachable from production releases.

## Decision

Map branches to environments: `dev` is the **dev** environment and `main` is **prod**. Builds receive `--dart-define=APP_ENV=dev|prod`, which `AppEnv.current` reads. Any value other than `prod` falls back to `dev`. Non-production builds show a banner. The release job runs in the `production` GitHub Environment, the only place signing secrets exist.

## Alternatives considered

- **Flutter flavors (separate Android product flavors and iOS schemes):** needed once dev and prod must be installed side by side or use different backends. That is more native setup than a template should impose; add flavors per project when needed.
- **A runtime switch (settings toggle):** a prod build could be switched to dev by accident.

## Consequences

One codebase and one build command per environment, with no native changes. Both environments share the same application ID until a project adds flavors.
