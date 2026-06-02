import Foundation

enum ProductBadge {
    case salesOfWeek   // flame.fill + "СКИДКИ НЕДЕЛИ"
}

struct Product: Identifiable {
    let id = UUID()
    let imageName: String        // asset name; placeholder fallback if absent
    let imageCount: Int          // page dots (1 = no dots)
    var isFavorite: Bool
    let badge: ProductBadge?
    let installmentPrice: String // "1398 ₸"
    let installmentTerm: String  // "×12 мес"
    let salePrice: String        // "16 769 ₸"
    let oldPrice: String?        // "154 967 ₸" (strikethrough)
    let discountPercent: Int?    // 89 → "-89%"
    let urgency: String?         // "218 шт осталось"
    let title: String
    let rating: Double           // 4.7
    let reviewCount: Int         // 6
    let deliveryDate: String     // "6 июня"
}
