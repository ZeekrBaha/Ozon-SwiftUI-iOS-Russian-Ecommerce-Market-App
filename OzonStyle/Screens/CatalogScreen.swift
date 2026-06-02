import SwiftUI

// Screen 2 — Каталог (design.md §4). Logo + search + 3-col category grid.
struct CatalogScreen: View {
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: Layout.gridSpacing),
        count: 3
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AppLogoHeader()

                SearchBar(fill: .searchFill, trailing: [.camera])
                    .padding(.horizontal, Layout.gutter)

                LazyVGrid(columns: columns, spacing: Layout.gridSpacing) {
                    ForEach(SampleData.categories) { category in
                        CategoryCard(category: category)
                    }
                }
                .padding(.horizontal, Layout.gutter)
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .background(Color.backgroundApp)
    }
}

#Preview { CatalogScreen() }
