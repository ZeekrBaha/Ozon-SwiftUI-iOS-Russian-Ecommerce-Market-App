# Architecture — Ozon-Style E-Commerce (iOS)

## 1. Approach

A flat, presentational SwiftUI app. No MVVM, no services, no async. Views read
directly from a static `SampleData` enum. State is limited to the selected tab
(`TabView` selection). This deliberately matches the "static prototype"
constraint — adding view models or repositories would violate spec §0.

## 2. File / group structure

```
OzonStyle/
  App/
    OzonStyleApp.swift          // @main, .tint(.brandPrimary), RootTabView
    RootTabView.swift           // TabView with 5 tabs (§3.3)

  DesignSystem/
    Color+Tokens.swift          // semantic colors (§design-system §1)
    Layout.swift                // spacing/corner constants (§design-system §2)
    Typography.swift            // font styles (§design-system §3)
    Brand.swift                 // wordmark name + brand colors (config switch)

  Models/
    Product.swift               // Product, ProductBadge
    Category.swift              // Category
    QuickAction.swift           // QuickAction
    SettingsItem.swift          // SettingsItem
    SampleData.swift            // ALL mock content lives here

  Components/
    AppLogoHeader.swift         // §3.2
    SearchBar.swift             // §4.1  (+ SearchTrailing enum)
    ProductImage.swift          // §3.0 placeholder rule
    ProductCard.swift           // §4.2  (+ ProductCardVariant enum)
    PriceBlock.swift            // §4.3
    RatingRow.swift             // §4.4  (+ ru pluralization)
    CTAButton.swift             // §4.5
    CategoryCard.swift          // §4.6
    FilterChip.swift            // §4.7  (SortChip + FilterChip)
    QuickActionTile.swift       // §4.8
    SettingsRow.swift           // §4.9
    SectionHeader.swift         // §4.10
    PrimaryButton.swift         // §4.11 (PrimaryButton + SoftButton)

  Screens/
    HomeScreen.swift            // Screen 1
    CatalogScreen.swift         // Screen 2
    FavoritesScreen.swift       // Screen 3
    CartScreen.swift            // Screen 4
    ProfileScreen.swift         // Screen 5

  Resources/
    Assets.xcassets             // colors (asset-backed tokens) + product/category/promo images
```

## 3. Data model (from spec §2)

```swift
enum ProductBadge { case salesOfWeek }   // flame.fill + "СКИДКИ НЕДЕЛИ"

struct Product: Identifiable {
    let id = UUID()
    let imageName: String        // asset name; §3.0 fallback if absent
    let imageCount: Int          // page dots (1 = no dots)
    var isFavorite: Bool
    let badge: ProductBadge?
    let installmentPrice: String // "1398 ₸"
    let installmentTerm: String  // "×12 мес"
    let salePrice: String        // "16 769 ₸"
    let oldPrice: String?        // "154 967 ₸" (strikethrough)
    let discountPercent: Int?    // 89 → "-89%"
    let urgency: String?         // "218 шт осталось"
    let title: String
    let rating: Double           // 4.7
    let reviewCount: Int         // 6
    let deliveryDate: String     // "6 июня"
}

struct Category: Identifiable { let id = UUID(); let title: String; let imageName: String }
struct QuickAction: Identifiable { let id = UUID(); let title: String; let imageName: String }
struct SettingsItem: Identifiable { let id = UUID(); let title: String; let value: String? }
```

### SampleData (single source; reuse instances across screens)

- `watch` — favorite, `.salesOfWeek` badge, -89%, "218 шт осталось". (Home/Favorites/Cart)
- `pedicure` — not favorite, no badge, no discount/urgency.
- `swimwear` — favorite, "Купальник раздельный…".
- `recommended: [Product]` — ≥6 (bikini, watches, wallet/clutch, …) reusing the above + simple additions.
- `viewed: [Product]` — `[watch, pedicure, swimwear, …]`.
- `categories: [Category]` — 18, exact order (see design.md Screen 2).
- `quickActions: [QuickAction]` — 6 (see design.md Screen 1).
- `settings: [SettingsItem]` — 5 (Валюта=KZT, Цвет приложения, Язык, Помощь, О приложении).

## 4. Component reuse map (the keystone rule)

| Screen     | Uses `ProductCard` variant | Grid |
|------------|---------------------------|------|
| Home       | `.grid`                   | 2-col `recommended` |
| Favorites  | `.featuredCompact` (1) + `.grid` | featured + 2-col `recommended` |
| Cart       | `.viewedGrid`             | 2-col `viewed` |
| Profile    | `.grid`                   | 2-col `recommended` |
| Catalog    | — (uses `CategoryCard`)   | 3-col `categories` |

`ProductCardVariant`: `.grid`, `.featuredCompact`, `.viewedGrid`. All variants
share **identical internal layout**; only the outer width container differs
(`.featuredCompact` is wrapped in `HStack { card; Spacer() }` by the screen).

## 5. Navigation & state

- `RootTabView` owns `@State private var selection` for the 5 tabs.
- No `NavigationStack` push targets (no detail screens). Each tab is a
  `ScrollView`-based screen.
- No `@StateObject`/`ObservableObject`. `SampleData` is a static enum.

## 6. Shared chrome rules (spec §3)

- **Safe area (HARD):** first content top padding = `safeAreaTop + 8`. Logo pill
  always below the status bar. On Home the logo sits inside the gradient (still
  below status bar).
- **AppLogoHeader:** centered, pill height 30pt, brand-blue capsule, white
  wordmark from `Brand`. Used on Catalog/Favorites/Cart/Profile and inside Home
  gradient.
- **Image placeholder (HARD):** `ProductImage(name:)` and category/quick-action
  images render the `searchFill` + `photo` fallback when the asset is missing.
