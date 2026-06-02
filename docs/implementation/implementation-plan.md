# Implementation Plan — Ozon-Style E-Commerce (iOS)

> Build order is fixed (spec §0): Tokens → Models/SampleData → Brand/AppLogoHeader
> → SearchBar → ProductCard → other components → Catalog → Favorites → Cart →
> Home → Profile → screenshot-verify each. Each task has acceptance criteria;
> nothing is "done" until its criteria pass.

## Phase 0 — Project scaffold

**T0. Create the Xcode project.**
- Files: new SwiftUI app `OzonStyle`, iOS 17 deployment target, no tests target
  needed, no third-party packages.
- Acceptance: project builds and runs an empty app on an iOS 17+ simulator.
- Risk: deployment target drift → pin to iOS 17.

## Phase 1 — Design tokens

**T1. `Color+Tokens.swift`, `Layout.swift`, `Typography.swift`.**
- Source: `design-system.md` §1–3 (use the table values verbatim).
- Colors are asset-catalog backed (add color sets in `Assets.xcassets`).
- Acceptance: a scratch preview renders all 12 colors, all 10 type styles, and
  reads each layout constant without compile errors. `.tint(.brandPrimary)` set
  at app root in `OzonStyleApp.swift`.

## Phase 2 — Models & data

**T2. Models.** `Product` (+ `ProductBadge`), `Category`, `QuickAction`, `SettingsItem`.
- Source: `architecture.md` §3 (copy field-for-field).
- Acceptance: types compile; `Product` is `Identifiable`.

**T3. `SampleData.swift`.** All mock content centralized.
- `watch`, `pedicure`, `swimwear` per spec §2 values; `recommended` (≥6,
  reusing instances + simple additions), `viewed = [watch, pedicure, swimwear, …]`,
  `categories` (18, exact order), `quickActions` (6), `settings` (5).
- Acceptance: no product field literals appear in any view later (red-line #7
  precursor); changing `watch.salePrice` here changes it on every screen.

## Phase 3 — Brand & shared chrome

**T4. `Brand.swift` + asset wordmark.** Wordmark name + brand colors behind config.
- Acceptance: screens never reference the literal "OZON" string or brand hex
  directly (red-line #8).

**T5. `AppLogoHeader.swift`.** Centered, pill 30pt, brand capsule, white wordmark.
- Acceptance: top padding = `safeAreaTop + 8`; pill sits below the status bar on
  every screen that uses it (red-line #1).

**T6. `ProductImage.swift`.** Asset load with `searchFill` + `photo` fallback.
- Acceptance: passing a non-existent asset name renders the placeholder, never
  blank/crash (F6).

## Phase 4 — Components

**T7. `SearchBar.swift`** (+ `SearchTrailing`). Per `design.md` §3.1.
- Acceptance: height 52, radius 14, correct trailing icons per fill variant.

**T8. `ProductCard.swift`** (+ `ProductCardVariant`) — the keystone. Per §3.2.
- Sub-components built in this task or split: `PriceBlock` (§3.3), `RatingRow`
  (§3.4, with ru pluralization), `CTAButton` (§3.5).
- Acceptance: one component renders `watch` (badge + discount + urgency + dots),
  `pedicure` (no badge/discount/urgency, no dots if `imageCount`==…), and a
  favorite vs non-favorite heart. `.featuredCompact` width == computed grid-card
  width.

**T9. Remaining components.** `CategoryCard` (§3.6), `FilterChip`/`SortChip`
(§3.7), `QuickActionTile` (§3.8), `SettingsRow` (§3.9), `SectionHeader` (§3.10),
`PrimaryButton`/`SoftButton` (§3.11).
- Acceptance: each matches its spec metrics in an isolated `#Preview`.

**T10. `RootTabView.swift` + 5-tab `TabView`.** Per `design.md` §2 table.
- Acceptance: 5 tabs, correct labels/symbols, active=`brandPrimary`,
  inactive=`textSecondary`, switching works (F1/F2).

## Phase 5 — Screens (build + verify each before the next)

> After each screen: build to simulator → screenshot → compare to reference →
> run that screen's checks in `validation-plan.md`. Do not start the next screen
> until the current one passes.

**T11. CatalogScreen** (Screen 2). Simplest screen; validates grid math + logo.
- Acceptance: centered logo below safe area; 3-col grid, 18 categories in exact
  order; computed card width; red-line #5 passes.

**T12. FavoritesScreen** (Screen 3).
- Acceptance: filter row; compact left-aligned featured `watch` card; 2-col
  `recommended` grid; red-line #2 passes.

**T13. CartScreen** (Screen 4, empty).
- Acceptance: full-width empty-state band on `backgroundApp` (not inset card);
  auto-width "Войти"; 2-col `viewed` grid with watch(heart)/pedicure(plain) and
  swimwear peeking; red-line #3 passes.

**T14. HomeScreen** (Screen 1).
- Acceptance: gradient header (~360, rounded bottom 24) containing logo + city +
  Войти pill + white search + hero promo + countdown pill, all inside the
  gradient; carousel banner with dots; quick-actions rail (6, exact order);
  "Рекомендуем" 2-col grid; red-line #6 passes.

**T15. ProfileScreen** (Screen 5).
- Acceptance: two separate white grouped sections (CTA + settings); 96pt gradient
  avatar; primary + soft buttons; settings rows with KZT pill + chevrons +
  hairlines; "Подобрали по вашим интересам" grid; red-line #4 passes.

## Phase 6 — Final pass

**T16. Full red-line sweep + Dynamic Type spot-check.**
- Acceptance: all 8 red-lines pass on a fresh launch across all tabs; bump
  Dynamic Type one step and confirm no clipped layouts / 2-line truncation holds
  (N2); write `validation-report.md`.

## Requirements → tasks → validation traceability

| Req | Task(s)      | Validated by |
|-----|--------------|--------------|
| F1/F2 | T10        | Tab switch check |
| F3  | T8           | Red-line #7 |
| F4  | T3           | Red-line #7 |
| F5  | T4           | Red-line #8 |
| F6  | T6           | Placeholder check |
| F7  | T14          | Home checks, red-line #6 |
| F8  | T11          | Catalog checks, red-line #5 |
| F9  | T12          | Favorites checks, red-line #2 |
| F10 | T13          | Cart checks, red-line #3 |
| F11 | T15          | Profile checks, red-line #4 |
| F12 | T7           | SearchBar variant check |
| N3  | T5           | Red-line #1 |
| N5  | T8/T11       | Grid-math check |

## Role review notes

- **PM:** scope is intentionally minimal — reject any add (detail nav, cart logic).
- **Developer:** never duplicate a card; reuse `ProductCard`. Compute grid widths.
- **Junior dev:** copy token values exactly from `design-system.md`; don't eyeball.
- **Tester:** the gate is visual + the 8 red-lines, run per-screen, not just a clean build.
- **Reviewer:** check for inline product literals, hardcoded brand strings/hex, and
  safe-area overlaps before approving.
- **Team lead:** enforce build order; each screen verified before the next.
