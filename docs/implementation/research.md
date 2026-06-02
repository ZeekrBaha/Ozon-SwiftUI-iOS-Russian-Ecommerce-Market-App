# Research — Ozon-Style E-Commerce (iOS)

> Spec-first research doc. Every important claim is labelled `Evidence`,
> `Repository fact`, or `Assumption`. No design decisions are made here except
> as clearly marked options.

## 1. Goal

Build a **static, presentational iOS prototype** that visually reproduces an
Ozon-style marketplace across five tabs: Home, Catalog, Favorites, Cart (empty),
Profile (logged out).

- `Evidence` (reference screenshots, 5 supplied): the UI shows Home with a blue
  gradient header + hero promo, a 3-column Catalog grid, a Favorites screen with
  one compact featured card, an empty Cart with a "Вы смотрели" grid, and a
  logged-out Profile with CTA + settings group.
- `Assumption`: this is a portfolio/learning prototype, not a shipping product —
  so no backend, accounts, or commerce flows are required.

## 2. Audience

- `Assumption`: the developer (Baha) building an iOS portfolio piece, and
  reviewers judging UI fidelity to the reference.

## 3. Success criteria

1. Each of the 5 screens matches its reference screenshot on layout, spacing,
   color, and typography (verified per-screen via simulator screenshot).
2. All 8 acceptance red-lines in `requirements.md` pass.
3. Exactly one interactive behavior works: tab switching. Everything else is
   inert by design.
4. Zero third-party dependencies; SwiftUI only; iOS 17+.

## 4. Constraints (binding)

- `Constraint` (from spec §0): **iOS 17+, SwiftUI only, zero third-party
  dependencies.** This overrides the skill's default web stack — native mobile
  is explicitly requested and the platform is pinned.
- `Constraint`: **Static prototype.** No networking, persistence, auth, async
  loading, or detail navigation. No view models, repositories, or services.
- `Constraint`: **Centralized mock data.** All product content comes from one
  `SampleData` source. Never hardcode product fields inside a view.
- `Constraint`: **One card component.** Every product tile on every screen is
  the same `ProductCard`, differing only by a `variant` enum. Per-screen
  duplicate cards are rejected.
- `Constraint`: **Branding behind a config switch.** The literal OZON wordmark
  and colors live in `Brand.swift`, swappable without touching screens.
- `Constraint`: **Localization is Russian/Kazakh-market.** Strings are Russian;
  currency is ₸ (KZT); city is Астана; "Сделано в Казахстане" appears. (Spec
  ships strings inline; a String Catalog is a non-goal for this prototype but
  noted as a future enhancement.)

## 5. Data sources & APIs

- `Repository fact`: none. All data is mock and lives in `SampleData`. No API,
  no network layer, no Context7 lookups needed for runtime data.
- `Evidence` (spec §2): the `Product`, `Category`, `QuickAction`, and
  `SettingsItem` model shapes are fully specified, including concrete sample
  values (watch, pedicure tool, swimwear, etc.).

## 6. Risks & unknowns

- `Risk — IP/Trademark (HIGH).` The prototype reproduces the literal **OZON**
  wordmark, the **О!РАСПРОДАЖА** promo lockup, and apparent third-party product
  photography. Acceptable for a private reference build; **must not be
  redistributed or shipped** without swapping the mark, promo art, and product
  images. Mitigation: all brand identity is isolated in `Brand.swift` + the
  asset catalog so a swap is a localized edit, not a screen rewrite.
- `Risk — asset stalls.` Missing image assets could crash or leave blank space.
  Mitigation: the §3.0 placeholder rule (rounded `searchFill` rect + SF Symbol
  `photo`) is mandatory for every image entry point.
- `Risk — safe-area overlap.` Prior builds let the custom logo pill overlap the
  status bar. Mitigation: hard rule — first content top padding = safeAreaTop +
  8; logo always below the status bar. This is acceptance red-line #1.
- `Unknown`: exact hero/promo artwork assets. `Assumption`: a single static
  promo image asset (`promo_hero`) plus a single static banner slide
  (`banner_postpayment`) are acceptable; the carousel may show one slide with
  dots.
- `Unknown`: full contents of `recommended` and a few extra products (bikini,
  wallet/clutch). `Assumption`: author ≥6 plausible products reusing the three
  fully-specified instances plus simple additions; centralize in `SampleData`.

## 7. Non-goals (explicit)

- No product detail screens, no add-to-cart logic, no search results.
- No dark mode tuning beyond Dynamic Type support (light UI matches reference).
- No String Catalog / `Localizable.xcstrings` in v1 (noted as future work).
- No unit/UI test suite beyond the per-screen screenshot verification gate
  (this is a presentational prototype; the validation gate is visual).
