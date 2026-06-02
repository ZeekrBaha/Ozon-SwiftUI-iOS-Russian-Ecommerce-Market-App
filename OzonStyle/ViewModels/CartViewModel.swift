import Foundation

// Screen 4 state — empty cart + "viewed" grid. `isEmpty` drives the empty band;
// it is fixed true in this prototype but lives here so cart logic has a home.
@MainActor
final class CartViewModel: ObservableObject {
    @Published private(set) var viewed: [Product]
    @Published private(set) var isEmpty: Bool = true
    let city = "Астана"

    init(repository: ProductRepository) {
        viewed = repository.viewedProducts()
    }
}
