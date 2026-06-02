import Foundation

// Screen 3 state — featured favorite + recommended grid.
@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var featured: Product
    @Published private(set) var recommended: [Product]

    init(repository: ProductRepository) {
        featured = repository.featuredFavorite()
        recommended = repository.recommendedProducts()
    }
}
