import SwiftUI

@main
struct OzonStyleApp: App {
    init() {
        // Inactive tab item color = textSecondary (design.md §2).
        let inactive = UIColor(Color.textSecondary)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.surfaceCard)
        for layout in [appearance.stackedLayoutAppearance,
                       appearance.inlineLayoutAppearance,
                       appearance.compactInlineLayoutAppearance] {
            layout.normal.iconColor = inactive
            layout.normal.titleTextAttributes = [.foregroundColor: inactive]
        }
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .tint(.brandPrimary)
        }
    }
}
