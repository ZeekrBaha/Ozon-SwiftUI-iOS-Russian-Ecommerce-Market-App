import Foundation

// Home carousel banner. `style` maps to a gradient/text-color in the view
// (colors stay in the view layer; only copy + style index live in data).
struct Banner: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let style: Int          // 0 blue · 1 light · 2 dark · 3 pink
}
