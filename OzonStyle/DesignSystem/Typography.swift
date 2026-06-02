import SwiftUI

// Type styles (design-system.md §3). System font at fixed point sizes for exact
// pixel fidelity to the reference screenshots. Trade-off: text does not scale
// with Dynamic Type; layouts are clip-safe at larger sizes because sizes are
// fixed (see validation-report.md, N2).
extension Font {
    static let screenTitle   = Font.system(size: 30, weight: .bold)
    static let sectionTitle  = Font.system(size: 28, weight: .bold)
    static let priceMain     = Font.system(size: 16, weight: .bold)
    static let installment   = Font.system(size: 15, weight: .semibold)
    static let cardTitle     = Font.system(size: 14, weight: .regular)
    static let bodyText      = Font.system(size: 15, weight: .regular)
    static let secondaryText = Font.system(size: 13, weight: .regular)
    static let badge         = Font.system(size: 11, weight: .bold)
    static let cta           = Font.system(size: 15, weight: .semibold)
    static let tabLabel      = Font.system(size: 11, weight: .regular)
}
