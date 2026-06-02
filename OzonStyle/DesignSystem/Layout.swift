import CoreGraphics

// Spacing & corner constants (design-system.md §2). Compute grid widths — never eyeball.
enum Layout {
    static let gutter: CGFloat         = 16   // global horizontal screen inset
    static let sectionSpacing: CGFloat = 24
    static let gridSpacing: CGFloat    = 12
    static let cardSpacing: CGFloat    = 12
    static let cornerCard: CGFloat     = 14
    static let cornerImage: CGFloat    = 12
    static let cornerSearch: CGFloat   = 14
    static let cornerButtonLg: CGFloat = 16
    static let cornerButtonSm: CGFloat = 12
    static let cornerSheet: CGFloat    = 24

    /// 2-col product grid card width.
    static func productCardWidth(screenW: CGFloat) -> CGFloat {
        (screenW - 2 * gutter - cardSpacing) / 2
    }
    /// 3-col category grid card width.
    static func categoryCardWidth(screenW: CGFloat) -> CGFloat {
        (screenW - 2 * gutter - 2 * gridSpacing) / 3
    }
}
