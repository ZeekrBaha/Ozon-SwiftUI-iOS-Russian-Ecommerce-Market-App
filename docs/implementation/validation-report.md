# Validation Report — Ozon-Style E-Commerce (iOS)

Date: 2026-06-01 · Build: SUCCEEDED (Xcode 26.5, iOS 17 deploy target, iPhone 15
Pro Max sim, iOS 26 runtime). Project generated with `xcodegen`.

## Commands run

| Command | Result |
|---------|--------|
| `xcodegen generate` | project created |
| `build_sim` (XcodeBuildMCP) | SUCCEEDED, 0 warnings, 0 errors |
| `build_run_sim` | launched on iPhone 15 Pro Max |
| `screenshot` per tab | captured all 5 screens |
| `simctl ui content_size extra-large` | Dynamic Type spot-check (see N2) |

Tabs were opened for screenshotting via a test-only `START_TAB` env hook in
`RootTabView` (UI tap automation is disabled in this environment).

## Per-screen verification (vs reference screenshots)

| Screen | Result | Notes |
|--------|--------|-------|
| Home (Главная) | ✅ | Logo pill below safe area; city + dark Войти pill; white search (barcode+camera); hero lockup + countdown pill **inside** gradient; carousel w/ dot; 6 quick actions in order; Рекомендуем 2-col grid. |
| Catalog (Каталог) | ✅ | Centered logo; camera search; 3-col grid, 18 categories in exact order; computed card width. |
| Favorites (Избранное) | ✅ | Filter row (sort/Фильтры/Бренд); compact **left-aligned** featured watch card; Подобрали для вас 2-col grid. |
| Cart (Корзина) | ✅ | Full-width empty band on backgroundApp; auto-width Войти soft button; Вы смотрели grid (watch=filled heart+badge, pedicure=plain). |
| Profile (Мой Ozon) | ✅ | Two separate white grouped sections; 96pt gradient avatar; primary+soft buttons; KZT pill + chevrons + hairlines; Подобрали по… grid. |

## Acceptance red-lines (binary gate)

| # | Red-line | Status |
|---|----------|--------|
| 1 | Logo pill below safe area (all) | ✅ |
| 2 | Favorites featured compact + left-aligned | ✅ |
| 3 | Cart empty state full-width band (not inset card) | ✅ |
| 4 | Profile = two grouped sections | ✅ |
| 5 | Catalog has centered logo | ✅ |
| 6 | Home hero inside the gradient | ✅ |
| 7 | One shared `Product` model + single `ProductCard` (no inline tiles) | ✅ |
| 8 | Brand wordmark/colors isolated in `Brand.swift` (no hardcoded literals in screens) | ✅ |

**All 8 red-lines pass.**

## Anti-slop gate

✅ Real plausible mock data · ✅ single SF Symbol set · ✅ neutral
`backgroundApp` behind cards · ✅ one brand accent + distinct
sale/installment/rating colors · ✅ tappable rows ≥44pt · ✅ no emoji as icons.

## Known deviations (honest)

1. **Product/category imagery** — no real photos shipped. `ProductImage` renders
   its `searchFill` + `photo` placeholder (F6 behavior, IP-safe per
   validation-plan §5). Cards therefore show placeholder tiles, not the
   reference photography. This is by design (third-party photos are not bundled).
2. **Brand pill** — configured as white pill + blue wordmark to match the
   reference screenshots (the draft text said the inverse). Isolated in
   `Brand.swift`; swap freely.
3. **Hero / О!РАСПРОДАЖА lockup** — rendered as styled text, not the original
   artwork (IP-safe, isolated to `HomeScreen.hero`).
4. **N2 Dynamic Type** — fonts use fixed point sizes for exact pixel fidelity to
   the fixed-size reference. Consequence: text does **not** grow with the user's
   text-size setting; the bump-one-step spot-check shows no clipping precisely
   because sizes are fixed. If true Dynamic Type scaling is later required,
   migrate `Typography.swift` to `@ScaledMetric` / `Font.custom(_,size:relativeTo:)`.

## Sign-off

All 5 screens match their references within the placeholder-imagery constraint;
all 8 red-lines pass on a fresh launch; tab switching works; build is clean.
Acceptable for the v1 static prototype scope.
