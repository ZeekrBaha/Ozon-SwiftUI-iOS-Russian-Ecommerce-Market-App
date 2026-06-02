import SwiftUI

// 5-tab root (design.md §2). Active = brandPrimary (via .tint), inactive = textSecondary.
struct RootTabView: View {
    @State private var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            HomeScreen()
                .tabItem { Label("Главная", systemImage: selection == 0 ? "house.fill" : "house") }
                .tag(0)

            CatalogScreen()
                .tabItem { Label("Каталог", systemImage: "magnifyingglass") }
                .tag(1)

            FavoritesScreen()
                .tabItem { Label("Избранное", systemImage: selection == 2 ? "heart.fill" : "heart") }
                .tag(2)

            CartScreen()
                .tabItem { Label("Корзина", systemImage: selection == 3 ? "basket.fill" : "basket") }
                .tag(3)

            ProfileScreen()
                .tabItem { Label("Мой Ozon", systemImage: selection == 4 ? "person.crop.circle.fill" : "person") }
                .tag(4)
        }
    }
}
