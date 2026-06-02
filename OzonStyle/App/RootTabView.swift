import SwiftUI

// 5-tab root (design.md §2). Each tab is a coordinator-owned NavigationStack
// (CoordinatedStack). Selection + all ViewModels/coordinators come from the
// injected AppCoordinator. Active = brandPrimary (via .tint), inactive =
// textSecondary.
struct RootTabView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            CoordinatedStack(coordinator: coordinator.homeCoordinator) {
                HomeScreen(viewModel: coordinator.homeViewModel,
                           onSelectProduct: coordinator.homeCoordinator.show)
            }
            .tabItem { Label("Главная", systemImage: coordinator.selectedTab == 0 ? "house.fill" : "house") }
            .tag(0)

            CoordinatedStack(coordinator: coordinator.catalogCoordinator) {
                CatalogScreen(viewModel: coordinator.catalogViewModel)
            }
            .tabItem { Label("Каталог", systemImage: "magnifyingglass") }
            .tag(1)

            CoordinatedStack(coordinator: coordinator.favoritesCoordinator) {
                FavoritesScreen(viewModel: coordinator.favoritesViewModel,
                                onSelectProduct: coordinator.favoritesCoordinator.show)
            }
            .tabItem { Label("Избранное", systemImage: coordinator.selectedTab == 2 ? "heart.fill" : "heart") }
            .tag(2)

            CoordinatedStack(coordinator: coordinator.cartCoordinator) {
                CartScreen(viewModel: coordinator.cartViewModel,
                           onSelectProduct: coordinator.cartCoordinator.show)
            }
            .tabItem { Label("Корзина", systemImage: coordinator.selectedTab == 3 ? "basket.fill" : "basket") }
            .tag(3)

            CoordinatedStack(coordinator: coordinator.profileCoordinator) {
                ProfileScreen(viewModel: coordinator.profileViewModel,
                              onSelectProduct: coordinator.profileCoordinator.show)
            }
            .tabItem { Label("Мой Ozon", systemImage: coordinator.selectedTab == 4 ? "person.crop.circle.fill" : "person") }
            .tag(4)
        }
    }
}

#Preview {
    RootTabView(coordinator: AppCoordinator())
}
