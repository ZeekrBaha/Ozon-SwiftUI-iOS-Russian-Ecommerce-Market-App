import SwiftUI

// Navigation destinations a coordinator can push onto its NavigationStack.
// Currently one route; add cases here (e.g. categoryProducts, cart) as the
// prototype grows — each gets a single home in `destination()`.
enum AppRoute: Hashable {
    case productDetail(Product)

    @ViewBuilder
    func destination() -> some View {
        switch self {
        case .productDetail(let product):
            ProductDetailScreen(product: product)
        }
    }
}

// Identity-based Hashable so a `Product` can travel inside an `AppRoute` value
// on a NavigationPath. Two products are equal iff they are the same instance.
extension Product: Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
