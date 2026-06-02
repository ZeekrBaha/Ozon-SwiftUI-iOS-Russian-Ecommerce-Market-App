import Foundation

// Screen 2 state — the category grid.
@MainActor
final class CatalogViewModel: ObservableObject {
    @Published private(set) var categories: [Category]

    init(repository: ProductRepository) {
        categories = repository.categories()
    }
}
