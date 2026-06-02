import Foundation

// Screen 5 state — settings rows + recommended grid.
@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var settings: [SettingsItem]
    @Published private(set) var recommended: [Product]

    init(repository: ProductRepository) {
        settings = repository.settings()
        recommended = repository.recommendedProducts()
    }
}
