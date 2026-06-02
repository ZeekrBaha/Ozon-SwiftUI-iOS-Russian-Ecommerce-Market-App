# Developer Prompt — Ozon-Style E-Commerce (iOS)

You are a senior iOS engineer. Build a **static, presentational SwiftUI
prototype** of an Ozon-style marketplace. Work strictly from the approved docs in
`docs/implementation/`. Do not invent requirements; if something is missing, mark
it and ask.

## Scope (do exactly this, no more)

- iOS 17+, **SwiftUI only, zero third-party dependencies.**
- 5 tabs via native `TabView`: Главная, Каталог, Избранное, Корзина, Мой Ozon.
- **Tab switching is the only interactive behavior.** Every other tap is inert.
- No networking, persistence, auth, async loading, detail navigation, view
  models, repositories, or services. Simplest code that renders the screens — no
  speculative abstraction or defensive bloat.

## Source of truth

- Layout & screens: `docs/implementation/design.md`
- Tokens: `docs/implementation/design-system.md` (use values verbatim)
- Data model & file tree: `docs/implementation/architecture.md`
- Task order & acceptance: `docs/implementation/implementation-plan.md`
- Gates: `docs/implementation/validation-plan.md`

## Build directives (do these)

- Follow the fixed build order: Tokens → Models/SampleData → Brand/AppLogoHeader →
  SearchBar → ProductCard → other components → Catalog → Favorites → Cart → Home →
  Profile, screenshot-verifying each screen before starting the next.
- Build **one** `ProductCard` with a `variant` enum and reuse it on Home,
  Favorites, Cart, and Profile. All variants share identical internal layout.
- Source **all** product/category/quick-action/settings content from
  `SampleData`. No product field literals inside any view.
- Put the OZON wordmark + brand colors in `Brand.swift`; screens reference
  `Brand`, never the literal "OZON" string or brand hex.
- **Compute** grid card widths from screen width, gutter, and spacing:
  - 2-col: `(screenW - 2*gutter - cardSpacing) / 2`
  - 3-col: `(screenW - 2*gutter - 2*gridSpacing) / 3`
- Respect the top safe area: first content top padding = `safeAreaTop + 8`; the
  logo pill always renders below the status bar.
- Every image path uses `ProductImage`/the §3.0 fallback: a `searchFill` rounded
  rect + centered SF Symbol `photo` when the asset is missing. Never crash or
  leave blank space.
- Support Dynamic Type via relative font sizing; 2-line truncation must not clip.

## Token block (embed verbatim)

Colors: `brandPrimary #005BFF`, `brandPrimarySoft #E4EEFF`, `priceSale #F0117E`,
`priceInstallment #F59E0B`, `ratingStar #FFA800`, `textPrimary #001A34`,
`textSecondary #707F8D`, `backgroundApp #F2F3F7`, `surfaceCard #FFFFFF`,
`searchFill #F4F6FA`, `buttonDark #050505`, `separator #E8EAEE`.
Layout: `gutter 16`, `sectionSpacing 24`, `gridSpacing 12`, `cardSpacing 12`,
`cornerCard 14`, `cornerImage 12`, `cornerSearch 14`, `cornerButtonLg 16`,
`cornerButtonSm 12`, `cornerSheet 24`.
Type: `screenTitle 30/bold`, `sectionTitle 28/bold`, `priceMain 16/bold`,
`installment 15/semibold`, `cardTitle 14/regular`, `body 15/regular`,
`secondary 13/regular`, `badge 11/bold`, `cta 15/semibold`, `tabLabel 11/regular`.
Set `.tint(.brandPrimary)` at app root; `backgroundApp` everywhere except white surfaces.

## Forbidden (anti-slop)

- No bespoke per-screen product cards — one `ProductCard` only.
- No hardcoded brand wordmark/colors inside screen views.
- No product field literals in views (everything via `SampleData`).
- No placeholder/lorem text — use the real mock strings from `SampleData`.
- No emoji as UI icons — use SF Symbols (flame/heart/star/basket/etc.).
- No pure-white app background behind cards — use `backgroundApp`.
- No invented features, navigation, or state beyond tab selection.
- No third-party packages.

## Reporting (after each screen and at the end)

- List exact changed/created files.
- Run the per-screen checklist + applicable red-lines from `validation-plan.md`;
  report pass/fail with the simulator screenshot.
- State any skipped check and any unresolved risk. Do not claim "done" from a
  clean build alone — verify on the running simulator against the reference.
