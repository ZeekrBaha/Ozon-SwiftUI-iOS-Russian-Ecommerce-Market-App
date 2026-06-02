# Design — Ozon-Style E-Commerce (iOS)

> UX flows, screens, states, and component APIs. Tokens are in
> `design-system.md` — referenced here, never re-defined. Verified against the 5
> reference screenshots.

## 1. Flows & states

- **Only flow:** launch → land on Home (Главная) → switch tabs via bottom bar.
- **States:** every screen is a single static state. There are no
  loading/error/auth states because there is no data fetching. The empty Cart is
  the one explicit "empty" state and it is the designed default (not a fallback).
- **Inert affordances:** search bars, hearts, chips, CTA buttons, settings rows,
  city pickers, and login buttons render fully but do nothing on tap.

## 2. Shared chrome (see `architecture.md` §6)

Safe-area rule, `AppLogoHeader`, bottom `TabView`, and the image placeholder
rule apply to all screens.

### Bottom tab bar (native `TabView`, 5 tabs)

| Tab       | Label      | SF Symbol (inactive / active)              |
|-----------|------------|--------------------------------------------|
| Home      | Главная    | `house` / `house.fill`                     |
| Catalog   | Каталог    | `magnifyingglass` (no filled variant; tint changes) |
| Favorites | Избранное  | `heart` / `heart.fill`                     |
| Cart      | Корзина    | `basket` / `basket.fill`                   |
| Profile   | Мой Ozon   | `person` / `person.crop.circle.fill`       |

White bar. Active icon+label `brandPrimary`; inactive `textSecondary`. Icon
~24pt, label `tabLabel` (11).

## 3. Component APIs

### 3.1 SearchBar
`SearchBar(fill: Color = .searchFill, trailing: [SearchTrailing])`
`enum SearchTrailing { case barcode, camera }` → `barcode.viewfinder`, `camera`
Height 52, radius 14, leading `magnifyingglass`, placeholder "Искать на Ozon",
internal h-padding 16. Non-interactive.
- Home: `fill: .white`, trailing `[.barcode, .camera]`.
- Catalog/Favorites: `fill: .searchFill`, trailing `[.camera]`.

### 3.2 ProductCard (keystone)
`ProductCard(product: Product, variant: ProductCardVariant)`
`enum ProductCardVariant { case grid, featuredCompact, viewedGrid }`
All variants share identical internal layout; only outer width differs
(`.grid`/`.viewedGrid` fill the cell; `.featuredCompact` is grid-card width,
wrapped `HStack { card; Spacer() }` by the screen).

Internal layout (top → bottom):
1. **Image block** — `aspectRatio(1.0, .fill)`, `cornerImage` 12, clipped. Overlays:
   - Heart top-right: `heart.fill` in `priceSale` when `isFavorite`, else `heart`
     in white over a subtle white circle. Inert.
   - Badge bottom-left (if `badge != nil`): capsule, `flame.fill` + "СКИДКИ НЕДЕЛИ",
     white text, `badge` font.
   - Page dots bottom-center if `imageCount > 1` (filled = first).
2. **PriceBlock** (§3.3)
3. **Title** — `cardTitle`, 2-line truncate.
4. **RatingRow** (§3.4)
5. **CTA** — `CTAButton(date: product.deliveryDate)` (§3.5)

Card bg `surfaceCard`, radius `cornerCard` 14, padding 10–12, no heavy border.

### 3.3 PriceBlock(product:)
- Line 1: `"\(installmentPrice) \(installmentTerm)"` in `priceInstallment`, `installment` font.
- Line 2: `salePrice` in `priceMain` (`priceSale` color); if `oldPrice != nil`,
  gray strikethrough beside it; if `discountPercent != nil`, `"-\(n)%"` in `priceSale`.
- Line 3 (if `urgency != nil`): urgency in `priceSale`, `secondary` size.

### 3.4 RatingRow(rating:reviewCount:)
`star.fill` (`ratingStar`) + bold rating + `bubble.left` (`textSecondary`) +
`"\(reviewCount) отзыв(а/ов)"` in `textSecondary`.
Pluralize: 1→отзыв, 2–4→отзыва, else→отзывов (with ru teen-exception: 11–14→отзывов).

### 3.5 CTAButton(date:)
Full-width, height 44, radius `cornerButtonSm` 12, `brandPrimary` fill, centered
`basket` + date in white, `cta` font. Inert.

### 3.6 CategoryCard(category:)
Fill `searchFill`, radius 16, slightly-tall square. Label top-left, 2-line max,
semibold (`body`). Image bottom-right, `.fit`, bleeds toward lower-right. Padding 12.

### 3.7 FilterChip
`SortChip()` — round, only `arrow.up.arrow.down`.
`FilterChip(.filters)` — `slider.horizontal.3` + "Фильтры".
`FilterChip(.brand)` — "Бренд".
Capsule, fill `searchFill`, height 42, h-padding 16. Inert.

### 3.8 QuickActionTile(action:)
56pt rounded image tile (radius 14) + 2-line centered caption (`secondary`).

### 3.9 SettingsRow(item:)
Height 56, leading title (`body`), optional trailing value pill (e.g. KZT in a
`searchFill` capsule), trailing `chevron.right` (`textSecondary`), hairline
`separator` divider below (inset to leading text). Inert.

### 3.10 SectionHeader(_ title:)
`sectionTitle` (28 bold, `textPrimary`), leading-aligned, `gutter` inset.

### 3.11 PrimaryButton / SoftButton
- PrimaryButton: height 56, radius `cornerButtonLg` 16, `brandPrimary` fill,
  white `cta`. Full-width within `gutter`.
- SoftButton: same metrics, `brandPrimarySoft` fill, `brandPrimary` text.
- Cart "Войти" is a smaller auto-width capsule variant (Screen 4).

---

## 4. Screens

### Screen 1 — Home / Главная
`ScrollView(.vertical)`, sections top→bottom:
1. **Gradient header** — full-width vertical blue gradient, height ~360, rounded
   bottom corners `cornerSheet` 24. Contains, in order:
   - `AppLogoHeader` (below safe area).
   - Header row (`gutter` inset): left "Астана" + `chevron.down` (white); right
     "Войти" pill on `buttonDark`, white text.
   - `SearchBar(fill: .white, trailing: [.barcode, .camera])`.
   - Hero promo: promo artwork + headline ("ПРАЗДНИК ПРИЛЕТИТ" / "О!РАСПРОДАЖА"
     lockup). Countdown pill on `buttonDark`: "19:45:13 до старта" + `chevron.right`.
     **The hero lives inside this gradient — not a separate card below.**
2. **Carousel banner** — full-width minus `gutter`, radius 16, height ~150,
   `TabView(.page)` dots. Single static slide acceptable; show dots.
3. **Quick actions rail** — horizontal `ScrollView`, `QuickActionTile` in order:
   Каталог, Быстрая доставка, Рассрочка 0-0-12, Сделано в Казахстане, Ozon Селект,
   Товары из Китая.
4. `SectionHeader("Рекомендуем")` → 2-col `ProductCard(variant: .grid)` from
   `SampleData.recommended`. Cards may begin partially under the tab bar.

### Screen 2 — Catalog / Каталог
`ScrollView`. Order: `AppLogoHeader` →
`SearchBar(fill: .searchFill, trailing: [.camera])` → 3-col `LazyVGrid` of
`CategoryCard`, `gutter` inset, `gridSpacing` 12.

Categories (exact order): Женская одежда, Мужская одежда, Обувь, Детская одежда,
Ювелирные украшения, Электроника, Бытовая техника, Красота и здоровье, Дом и сад,
Мебель, Аксессуары, Строительство и ремонт, Автотовары, Продукты питания,
Товары для животных, Детские товары, Спорт и отдых, Книги.

### Screen 3 — Favorites / Избранное
`ScrollView`. Order:
1. `AppLogoHeader`
2. `SearchBar(fill: .searchFill, trailing: [.camera])`
3. Filter row (horizontal, `gutter` inset): `SortChip()`, `FilterChip(.filters)`, `FilterChip(.brand)`.
4. Featured product — left-aligned, compact:
   `HStack { ProductCard(product: SampleData.watch, variant: .featuredCompact); Spacer() }`
   `.padding(.horizontal, gutter)`. Card width = grid-card width; blank
   `backgroundApp` to the right.
5. `SectionHeader("Подобрали для вас")` → 2-col `.grid` from `SampleData.recommended`.

### Screen 4 — Cart / Корзина (empty)
`ScrollView`. Order:
1. `AppLogoHeader`
2. City row (`gutter` inset): "Астана" + `chevron.down` (`textPrimary`).
3. **Empty-state band** — full-width, background `backgroundApp` (NOT an inset
   white card). Centered, top/bottom padding 32:
   - Title "Корзина пуста" (`sectionTitle`).
   - Body (`body`, `textSecondary`, centered): "Воспользуйтесь поиском, чтобы найти
     всё, что нужно. Если в Корзине были товары, войдите, чтобы посмотреть список".
   - Button "Войти": `brandPrimarySoft` fill, `brandPrimary` text, capsule-ish
     rounded rect, auto-width (not full-width), centered.
4. `SectionHeader("Вы смотрели")` → 2-col `.viewedGrid` from `SampleData.viewed`.
   First card (watch) has filled red heart; second (pedicure) shows no
   discount/urgency. A third row (swimwear) peeks above the tab bar.

### Screen 5 — Profile / Мой Ozon (logged out)
`ScrollView`. **Two separate white grouped sections** on `backgroundApp`:

**A. CTA section** — full-width white surface, rounded bottom corners
`cornerSheet` 24, centered content, top→bottom:
1. `AppLogoHeader`
2. Avatar: 96pt circle, blue radial/linear gradient, centered white `person.fill`.
3. Title "Войдите в личный кабинет" (`screenTitle` 30 bold).
4. Subtitle (`body`, `textSecondary`, centered, 2 lines): "Отслеживайте заказы,
   копите баллы и пользуйтесь персональными скидками".
5. `PrimaryButton("Войти или зарегистрироваться")`.
6. `SoftButton("Покупайте как юрлицо")`.
7. Caption (`secondary`, `textSecondary`): "Применяем" + blue inline link
   "рекомендательные технологии".

**B. Settings group** — white surface, rounded corners 20, `gutter` inset,
`SettingsRow`s with hairline separators:
Валюта (value pill KZT), Цвет приложения, Язык, Помощь, О приложении.

**C.** `SectionHeader("Подобрали по вашим интересам")` → 2-col `.grid`
(top edge visible above tab bar).

## 5. Reviewer pass (design)

- ✅ Single `ProductCard` covers all 4 product surfaces (red-line #7).
- ✅ Favorites featured is compact + left-aligned (red-line #2).
- ✅ Cart empty state is a full-width band, not an inset card (red-line #3).
- ✅ Profile is two grouped sections (red-line #4).
- ✅ Home hero inside the gradient (red-line #6).
- ✅ Catalog has centered logo (red-line #5).
- ⚠️ Confirm during build: `featuredCompact` width equals computed grid-card
  width (not an arbitrary fixed point).
- ⚠️ Confirm: page dots only render when `imageCount > 1`.
