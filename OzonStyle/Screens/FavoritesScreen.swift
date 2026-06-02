import SwiftUI

// Screen 3 — Избранное (design.md §4). Filter row + compact featured + 2-col grid.
struct FavoritesScreen: View {
    @ObservedObject var viewModel: FavoritesViewModel
    let onSelectProduct: (Product) -> Void

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: Layout.cardSpacing),
        count: 2
    )

    private var featuredWidth: CGFloat {
        Layout.productCardWidth(screenW: UIScreen.main.bounds.width)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AppLogoHeader()

                SearchBar(fill: .searchFill, trailing: [.camera])
                    .padding(.horizontal, Layout.gutter)

                // Filter row
                HStack(spacing: 10) {
                    SortChip()
                    FilterChip(kind: .filters)
                    FilterChip(kind: .brand)
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, Layout.gutter)

                // Featured: compact, left-aligned (red-line #2)
                HStack {
                    ProductCard(product: viewModel.featured, variant: .featuredCompact)
                        .frame(width: featuredWidth)
                        .onTapGesture { onSelectProduct(viewModel.featured) }
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, Layout.gutter)

                SectionHeader("Подобрали для вас")

                LazyVGrid(columns: columns, spacing: Layout.gridSpacing) {
                    ForEach(viewModel.recommended) { product in
                        ProductCard(product: product, variant: .grid)
                            .onTapGesture { onSelectProduct(product) }
                    }
                }
                .padding(.horizontal, Layout.gutter)
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .background(Color.backgroundApp)
        .navigationBarHidden(true)
    }
}

#Preview {
    FavoritesScreen(viewModel: FavoritesViewModel(repository: SampleDataRepository()),
                    onSelectProduct: { _ in })
}
