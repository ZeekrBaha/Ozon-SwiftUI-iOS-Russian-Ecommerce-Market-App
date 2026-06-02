import SwiftUI

// Brand isolation (design-system.md §7, red-line #8).
// All OZON identity lives here so it can be swapped without touching screens.
// Screens/components reference `Brand.*`, never the literal string or hex.
//
// Note: reference screenshots show a WHITE pill with BLUE wordmark, so that is
// the configured default here (the draft text said the inverse). Swap freely.
enum Brand {
    static let wordmark: String = "OZON"

    static let pillColor: Color     = .surfaceCard     // white pill
    static let wordmarkColor: Color = .brandPrimary    // blue letters

    // Avatar / promo gradient anchors (Profile avatar, Home header).
    static let gradientTop: Color    = Color(red: 0.18, green: 0.45, blue: 1.0)
    static let gradientBottom: Color = Color(red: 0.0,  green: 0.36, blue: 1.0)
}
