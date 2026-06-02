# Ozon-Style iOS

A Russian-language e-commerce storefront built in SwiftUI for iOS 17+, recreating the OZON marketplace UI from a spec + 5 reference screenshots. A static, presentational prototype: five tabs, one reusable product card, zero dependencies.

---

## Screenshots

| Home (Главная) | Catalog (Каталог) | Favorites (Избранное) |
|----------------|-------------------|-----------------------|
| ![Home](docs/screenshots/01_home.png) | ![Catalog](docs/screenshots/02_catalog.png) | ![Favorites](docs/screenshots/03_favorites.png) |

| Cart (Корзина) | Profile (Мой Ozon) |
|----------------|--------------------|
| ![Cart](docs/screenshots/04_cart.png) | ![Profile](docs/screenshots/05_profile.png) |

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| UI | SwiftUI (iOS 17) |
| Architecture | Flat / presentational — no MVVM, no services, no async |
| State | `TabView` selection only |
| Data | Static `SampleData` enum (single source of truth) |
| Images | Asset-catalog imagesets + `ProductImage` placeholder fallback |
| Project | XcodeGen (`project.yml`) |
| Dependencies | None |

---

## Architecture

A deliberately flat app. Views read directly from a static `SampleData` enum; the
only mutable state is the selected tab. Adding view models or repositories would
violate the "static prototype" constraint.

### Layer overview

```
┌──────────────────────────────────────────────┐
│                OzonStyleApp                   │
│   @main · .tint(.brandPrimary)                │
│            ↓                                  │
│        RootTabView  (@State selection)        │
│   5 native TabView tabs                       │
└───────────────────┬──────────────────────────┘
                    │
        ┌───────────┴───────────────────────────┐
        │            Screens                     │
        │  Home · Catalog · Favorites · Cart ·   │
        │  Profile  (each a ScrollView)          │
        └───────────┬───────────────────────────┘
                    │ compose
        ┌───────────┴───────────────────────────┐
        │           Components                   │
        │  ProductCard (keystone) → PriceBlock,  │
        │  RatingRow, CTAButton                  │
        │  SearchBar · CategoryCard · FilterChip │
        │  QuickActionTile · SettingsRow · …     │
        └───────────┬───────────────────────────┘
                    │ read
        ┌───────────┴───────────────────────────┐
        │   SampleData (static enum)             │
        │   products · categories · quickActions │
        │   · settings   (no inline literals)    │
        └────────────────────────────────────────┘
```

### The keystone rule — one card, every surface

A single `ProductCard` renders every product across all screens. Variants change
only the **outer width**, never the internal layout.

```
ProductCard(product:variant:)
  variant ─┬─ .grid           → fills a 2-col grid cell   (Home/Favorites/Profile)
           ├─ .viewedGrid      → fills a 2-col grid cell   (Cart "Вы смотрели")
           └─ .featuredCompact → grid-card width, screen wraps HStack{card; Spacer()}
                                                          (Favorites featured)

internal layout (identical for all variants):
  image (1:1, heart · badge · page-dots)
    → PriceBlock (installment / sale+old+discount / urgency)
    → title (2-line)
    → RatingRow (★ rating · ru-pluralized review count)
    → CTAButton (basket + delivery date)
```

### Design tokens (single source)

```
DesignSystem/
  Color+Tokens.swift   12 semantic colors, asset-catalog backed
                       (declared on ShapeStyle where Self == Color so
                        `.foregroundStyle(.token)` resolves)
  Layout.swift         gutter=16 global · grid math computed, never eyeballed
  Typography.swift     10 fixed-size system styles
  Brand.swift          OZON wordmark + brand colors isolated here
```

### Brand isolation

All OZON identity (wordmark, brand colors, hero lockup colors) lives in
`Brand.swift`. Screens reference `Brand.*`, never the literal `"OZON"` string or
brand hex — so the identity can be swapped without touching any screen.

---

## Project Structure

```
OzonStyle/
├── App/
│   ├── OzonStyleApp.swift        @main, .tint, tab-bar appearance
│   └── RootTabView.swift         5-tab TabView
├── DesignSystem/
│   ├── Color+Tokens.swift        12 semantic colors
│   ├── Layout.swift              spacing / corner constants + grid math
│   ├── Typography.swift          10 type styles
│   └── Brand.swift               wordmark + brand colors (isolated)
├── Models/
│   ├── Product.swift             Product + ProductBadge
│   ├── Category.swift  QuickAction.swift  SettingsItem.swift
│   └── SampleData.swift          ALL mock content
├── Components/
│   ├── ProductCard.swift         keystone (+ ProductCardVariant)
│   ├── PriceBlock · RatingRow · CTAButton
│   ├── SearchBar · ProductImage · CategoryCard
│   ├── FilterChip (Sort + Filter) · QuickActionTile
│   ├── SettingsRow · SectionHeader · PrimaryButton (+ SoftButton)
│   └── AppLogoHeader.swift        centered brand pill
├── Screens/
│   ├── HomeScreen.swift           gradient header + hero + carousel + grid
│   ├── CatalogScreen.swift        3-col category grid
│   ├── FavoritesScreen.swift      filter row + compact featured + grid
│   ├── CartScreen.swift           empty-state band + "Вы смотрели"
│   └── ProfileScreen.swift        two grouped sections + settings
└── Resources/
    └── Assets.xcassets            12 color sets · AppIcon · 30 imagesets
```

---

## Setup

### Prerequisites

- Xcode 16+ (built with Xcode 26.5), iOS 17 simulator
- [XcodeGen](https://github.com/yonaskolb/XcodeGen): `brew install xcodegen`

### Steps

```bash
git clone <repo>
cd Ozon-SwiftUI-iOS-Russian-Ecommerce-Market-App

xcodegen generate          # regenerates OzonStyle.xcodeproj
open OzonStyle.xcodeproj
```

The project has **no third-party packages** — it builds and runs as-is.

---

## Design fidelity & validation

Verified against the 5 reference screenshots on an iPhone 15 Pro Max simulator.
The gate is visual fidelity + **8 binary red-lines** (full report in
[`docs/implementation/validation-report.md`](docs/implementation/validation-report.md)):

| # | Red-line | Status |
|---|----------|--------|
| 1 | Logo pill always below the safe area | ✅ |
| 2 | Favorites featured card compact + left-aligned (never full-width) | ✅ |
| 3 | Cart empty state is a full-width band (not an inset card) | ✅ |
| 4 | Profile = two separate grouped sections | ✅ |
| 5 | Catalog has the centered logo | ✅ |
| 6 | Home hero lives inside the gradient header | ✅ |
| 7 | One shared `Product` model + single `ProductCard` (no inline tiles) | ✅ |
| 8 | Brand wordmark/colors never hardcoded in screen views | ✅ |

---

## Known constraints (v1 prototype)

- **Static & inert** — search bars, hearts, chips, CTAs, settings rows, and login
  buttons render fully but do nothing on tap. Only tab switching is interactive.
- **Placeholder imagery** — product/category photos are low-res keyword-matched
  stand-ins (`ProductImage` falls back to a `photo` glyph when an asset is
  missing). Bundle imagery is intentionally small (~150 KB total).
- **Fixed-size type** — fonts use fixed point sizes for exact pixel fidelity to
  the fixed-size reference; text does not scale with Dynamic Type.
- **IP** — the OZON wordmark, the О!РАСПРОДАЖА hero lockup, and the third-party
  stand-in photos are isolated in `Brand.swift` + the asset catalog and should be
  swapped before any non-prototype use.

---

## Documentation

Spec-first docs that drove the build live in [`docs/`](docs/):
research, requirements, design-system, design, architecture, implementation-plan,
validation-plan, validation-report, and the developer prompt.
