# Ozon-Style E-Commerce (iOS) — Implementation Docs

Spec-first documentation package for a static, presentational SwiftUI prototype
of an Ozon-style marketplace (iOS 17+, zero dependencies). Built from the v2
build-ready spec + 5 verified reference screenshots.

## Read in this order

1. [`implementation/research.md`](implementation/research.md) — goal, constraints, stack decision, IP risk, unknowns.
2. [`implementation/requirements.md`](implementation/requirements.md) — functional/non-functional reqs + the 8 acceptance red-lines.
3. [`implementation/design-system.md`](implementation/design-system.md) — **tokens** (color/spacing/type/shape). Reuse verbatim.
4. [`implementation/design.md`](implementation/design.md) — component APIs + per-screen specs (all 5 screens).
5. [`implementation/architecture.md`](implementation/architecture.md) — file tree, data model, component reuse map.
6. [`implementation/implementation-plan.md`](implementation/implementation-plan.md) — ordered tasks T0–T16 with acceptance criteria + traceability.
7. [`implementation/validation-plan.md`](implementation/validation-plan.md) — per-screen checklist, red-lines, anti-slop gate.
8. [`prompts/developer.md`](prompts/developer.md) — the implementation prompt (embeds tokens + slop ban).

`implementation/validation-report.md` is written during the final pass (T16).

## The non-negotiables (one glance)

- One `ProductCard` (variant enum) on every product surface — no per-screen cards.
- All content from `SampleData` — no product literals in views.
- Brand behind `Brand.swift` — no hardcoded "OZON"/brand hex in screens.
- Logo always below the safe area.
- Build order is fixed; screenshot-verify each screen before the next.

## Status

Planning complete. Coding has **not** started — begin with task **T0** in the
implementation plan once approved.
