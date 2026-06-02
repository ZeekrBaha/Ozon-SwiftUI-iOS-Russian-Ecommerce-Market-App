import SwiftUI

// Semantic color tokens, asset-catalog backed (design-system.md §1).
// Declared on `ShapeStyle where Self == Color` so the leading-dot shorthand
// resolves in `.foregroundStyle(.token)` / `.background(.token)` contexts AND as
// `Color.token`. Screens reference these names only — never raw hex.
extension ShapeStyle where Self == Color {
    static var brandPrimary: Color     { Color("brandPrimary") }
    static var brandPrimarySoft: Color { Color("brandPrimarySoft") }
    static var priceSale: Color        { Color("priceSale") }
    static var priceInstallment: Color { Color("priceInstallment") }
    static var ratingStar: Color       { Color("ratingStar") }
    static var textPrimary: Color      { Color("textPrimary") }
    static var textSecondary: Color    { Color("textSecondary") }
    static var backgroundApp: Color    { Color("backgroundApp") }
    static var surfaceCard: Color      { Color("surfaceCard") }
    static var searchFill: Color       { Color("searchFill") }
    static var buttonDark: Color       { Color("buttonDark") }
    static var separator: Color        { Color("separator") }
}
