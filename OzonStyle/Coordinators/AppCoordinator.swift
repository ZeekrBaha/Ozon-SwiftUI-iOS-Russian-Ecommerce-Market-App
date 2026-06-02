import SwiftUI

// MARK: - Per-tab coordinator

// Owns one tab's navigation state and exposes navigation intent. Views send
// intent (`show(_:)`) instead of constructing destinations themselves.
@MainActor
final class TabCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func show(_ product: Product) {
        path.append(AppRoute.productDetail(product))
    }

    func popToRoot() {
        path = NavigationPath()
    }
}

// MARK: - App coordinator

// Composition root. Builds the single repository, every ViewModel, and every
// tab coordinator once, then hands stable instances to the view layer. Also
// holds the selected-tab state for the root TabView.
@MainActor
final class AppCoordinator: ObservableObject {
    @Published var selectedTab: Int = 0

    let homeViewModel: HomeViewModel
    let catalogViewModel: CatalogViewModel
    let favoritesViewModel: FavoritesViewModel
    let cartViewModel: CartViewModel
    let profileViewModel: ProfileViewModel

    let homeCoordinator = TabCoordinator()
    let catalogCoordinator = TabCoordinator()
    let favoritesCoordinator = TabCoordinator()
    let cartCoordinator = TabCoordinator()
    let profileCoordinator = TabCoordinator()

    init(repository: ProductRepository = SampleDataRepository()) {
        homeViewModel = HomeViewModel(repository: repository)
        catalogViewModel = CatalogViewModel(repository: repository)
        favoritesViewModel = FavoritesViewModel(repository: repository)
        cartViewModel = CartViewModel(repository: repository)
        profileViewModel = ProfileViewModel(repository: repository)
    }
}

// MARK: - Coordinated NavigationStack wrapper

// Wraps a tab's root screen in a NavigationStack bound to its coordinator's
// path and registers the shared route → destination mapping. Generic over the
// root so every tab reuses the same navigation plumbing.
struct CoordinatedStack<Root: View>: View {
    @ObservedObject var coordinator: TabCoordinator
    @ViewBuilder let root: () -> Root

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            root()
                .navigationDestination(for: AppRoute.self) { route in
                    route.destination()
                }
        }
    }
}
