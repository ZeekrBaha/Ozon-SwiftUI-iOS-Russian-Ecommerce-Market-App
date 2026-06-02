import Foundation

// Screen 1 state. Owns the carousel index + auto-advance logic (was previously
// inline in the view).
@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var banners: [Banner]
    @Published private(set) var quickActions: [QuickAction]
    @Published private(set) var recommended: [Product]
    @Published var bannerIndex: Int = 0

    init(repository: ProductRepository) {
        banners = repository.banners()
        quickActions = repository.quickActions()
        recommended = repository.recommendedProducts()
    }

    // Advance one slide, wrapping. No-op when there are no banners.
    func advanceBanner() {
        guard !banners.isEmpty else { return }
        bannerIndex = (bannerIndex + 1) % banners.count
    }
}
