# Requirements — Ozon-Style E-Commerce (iOS)

## 1. Functional requirements

| ID  | Requirement | Source |
|-----|-------------|--------|
| F1  | App presents 5 tabs via native `TabView`: Главная, Каталог, Избранное, Корзина, Мой Ozon. | Spec §3.3, Evidence (all screenshots) |
| F2  | Tab switching is the **only** interactive behavior. All other taps are inert. | Spec §0 |
| F3  | All product tiles render from the shared `Product` model via a single `ProductCard` with a `variant`. | Spec §0, §4.2 |
| F4  | All product data is sourced from `SampleData`; no inline product fields in views. | Spec §0, §2 |
| F5  | Brand wordmark + brand colors are resolved through `Brand.swift` / tokens, never hardcoded in screens. | Spec §0, §7.8 |
| F6  | Every image entry point falls back to a `searchFill` rounded rect + SF Symbol `photo` when the asset is absent. | Spec §3.0 |
| F7  | Home shows: gradient header (logo + city + Войти pill + search + hero promo), carousel banner, quick-actions rail, "Рекомендуем" 2-col grid. | Spec Screen 1, Evidence |
| F8  | Catalog shows: centered logo, search bar, 3-col category grid of 18 categories in exact order. | Spec Screen 2, Evidence |
| F9  | Favorites shows: logo, search, filter row (Sort/Фильтры/Бренд), one **compact left-aligned** featured card, "Подобрали для вас" 2-col grid. | Spec Screen 3, Evidence |
| F10 | Cart (empty) shows: logo, city row, full-width empty-state band (Корзина пуста + body + Войти), "Вы смотрели" 2-col grid. | Spec Screen 4, Evidence |
| F11 | Profile (logged out) shows: white CTA section (logo, avatar, title, subtitle, primary + soft buttons, caption), separate white settings group (5 rows), "Подобрали по вашим интересам" grid. | Spec Screen 5, Evidence |
| F12 | Search bars are display-only (non-interactive), with per-screen fill + trailing-icon variants. | Spec §4.1 |

## 2. Non-functional requirements

| ID  | Requirement |
|-----|-------------|
| N1  | iOS 17+, SwiftUI only, zero third-party dependencies. |
| N2  | All text supports Dynamic Type (relative font sizing); 2-line truncation must not clip layout. |
| N3  | Every screen respects the top safe area; custom header never overlaps the status bar. |
| N4  | App tint = `brandPrimary` at root; app background = `backgroundApp` except inside white surfaces. |
| N5  | Grid card widths are **computed** from screen width, gutter, and spacing — never eyeballed/hardcoded. |
| N6  | No crash and no blank space on any missing asset (see F6). |

## 3. Acceptance red-lines (reject build if ANY fail)

These are hard fails, copied from spec §7. The validation gate checks each.

1. **Logo pill never aligned with the status-bar clock/battery** — must sit below the safe area.
2. **Favorites featured card never full-width** — must be compact, left-aligned, grid-card width.
3. **Cart empty state never an inset white card** — must be a full-width band on `backgroundApp`.
4. **Profile CTA + Settings never collapsed into one block** — must be two separate grouped sections.
5. **Catalog never missing the centered logo.**
6. **Home hero never detached from the gradient header** — it lives inside the gradient.
7. **No product tile built outside the shared `Product` model + single `ProductCard`** — no bespoke per-screen cards.
8. **Brand wordmark/colors never hardcoded inside screen views** — always via `Brand`/tokens.

## 4. Out of scope

See `research.md` §7 (non-goals). No detail nav, no commerce logic, no
persistence, no networking, no test suite beyond the visual gate.
