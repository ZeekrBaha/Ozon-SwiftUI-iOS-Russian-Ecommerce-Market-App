# Validation Plan — Ozon-Style E-Commerce (iOS)

> Define checks before coding. For this prototype the gate is **visual fidelity +
> the 8 red-lines**, verified per-screen on a running simulator — not a clean
> build alone (spec §6).

## 1. Commands / checks

| Check | How | When |
|-------|-----|------|
| Compile | Xcode build (XcodeBuildMCP `build_sim`) | every task |
| Run | `build_run_sim` on an iOS 17+ simulator | every screen |
| Screenshot | XcodeBuildMCP `screenshot` per tab | every screen |
| Compare | Screenshot vs the matching reference image | every screen |
| Dynamic Type | Bump Larger Text one step, re-screenshot | final pass (T16) |
| Missing-asset | Temporarily pass a bogus asset name to `ProductImage` | T6 |

There is no unit/UI test suite by design (presentational prototype). If desired
later, add snapshot tests — out of scope for v1.

## 2. Per-screen verification checklist (run after each screen — spec §6)

For every screen, confirm:
- [ ] Logo pill sits **below** the safe area (never on the status-bar row).
- [ ] Search bar height 52 / radius 14 (where present).
- [ ] `backgroundApp` everywhere except inside white surfaces.
- [ ] Grid spacing 12 and **computed** card width (not hardcoded).
- [ ] `ProductCard` width correct for its variant.
- [ ] Tab active = `brandPrimary`, inactive = `textSecondary`.
- [ ] 2-line truncation intact (no clipping).
- [ ] Card radius 14; CTA height 44.
- [ ] Safe-area top spacing = `safeAreaTop + 8`.

## 3. Acceptance red-lines (binary, reject if ANY fail — spec §7)

| # | Red-line | Screen |
|---|----------|--------|
| 1 | Logo pill never aligned with status-bar clock/battery (must be below safe area) | all |
| 2 | Favorites featured card never full-width (compact, left-aligned) | Favorites |
| 3 | Cart empty state never an inset white card (full-width band on `backgroundApp`) | Cart |
| 4 | Profile CTA + Settings never one block (two grouped sections) | Profile |
| 5 | Catalog never missing the centered logo | Catalog |
| 6 | Home hero never detached from the gradient header | Home |
| 7 | No product tile outside the shared `Product` model + single `ProductCard` | all |
| 8 | Brand wordmark/colors never hardcoded inside screen views | all |

## 4. Anti-slop gate (adapted for native iOS)

- [ ] Real, plausible mock data on every card (no "Lorem"/placeholder titles).
- [ ] Single icon set (SF Symbols) at consistent sizes.
- [ ] Neutral background (`backgroundApp` #F2F3F7), not pure `#fff`, behind cards.
- [ ] One accent for brand (`brandPrimary`), distinct sale/installment/rating colors — no random gradient soup.
- [ ] Touch targets / tappable rows ≥ 44pt where applicable.
- [ ] Dynamic Type supported; contrast of secondary text on white passes AA.
- [ ] No emoji used as UI icons (flame/heart/star are SF Symbols, per spec).

## 5. IP / brand check before any sharing

- [ ] If this leaves a private reference context, the OZON wordmark,
      О!РАСПРОДАЖА lockup, and third-party product photos are swapped (all
      isolated in `Brand.swift` + asset catalog).

## 6. Sign-off

Build is acceptable when: all 5 screens pass their per-screen checklist, all 8
red-lines pass on a fresh launch, the Dynamic Type spot-check is clean, and
`validation-report.md` records the commands run and any skipped checks.
