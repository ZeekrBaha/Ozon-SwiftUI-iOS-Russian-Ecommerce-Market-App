import SwiftUI

// Screen 4 — Корзина, empty (design.md §4). Full-width empty band (red-line #3).
struct CartScreen: View {
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: Layout.cardSpacing),
        count: 2
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AppLogoHeader()

                // City row
                HStack(spacing: 4) {
                    Text("Астана")
                        .font(.bodyText)
                        .foregroundStyle(.textPrimary)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.textPrimary)
                    Spacer()
                }
                .padding(.horizontal, Layout.gutter)

                // Empty-state band — full-width on backgroundApp, NOT an inset card
                VStack(spacing: 12) {
                    Text("Корзина пуста")
                        .font(.sectionTitle)
                        .foregroundStyle(.textPrimary)
                    Text("Воспользуйтесь поиском, чтобы найти всё, что нужно. Если в Корзине были товары, войдите, чтобы посмотреть список")
                        .font(.bodyText)
                        .foregroundStyle(.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Layout.gutter)
                    Text("Войти")
                        .font(.cta)
                        .foregroundStyle(.brandPrimary)
                        .padding(.horizontal, 28)
                        .frame(height: 44)
                        .background(.brandPrimarySoft, in: RoundedRectangle(cornerRadius: Layout.cornerButtonSm))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)

                SectionHeader("Вы смотрели")

                LazyVGrid(columns: columns, spacing: Layout.gridSpacing) {
                    ForEach(SampleData.viewed) { product in
                        ProductCard(product: product, variant: .viewedGrid)
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

#Preview { CartScreen() }
