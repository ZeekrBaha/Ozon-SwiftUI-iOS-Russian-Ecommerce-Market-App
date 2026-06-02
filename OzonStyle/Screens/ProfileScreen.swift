import SwiftUI

// Screen 5 — Мой Ozon, logged out (design.md §4). Two separate grouped
// sections on backgroundApp (red-line #4).
struct ProfileScreen: View {
    @ObservedObject var viewModel: ProfileViewModel
    let onSelectProduct: (Product) -> Void

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: Layout.cardSpacing),
        count: 2
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ctaSection
                settingsSection
                    .padding(.horizontal, Layout.gutter)

                SectionHeader("Подобрали по вашим интересам")

                LazyVGrid(columns: columns, spacing: Layout.gridSpacing) {
                    ForEach(viewModel.recommended) { product in
                        ProductCard(product: product, variant: .grid)
                            .onTapGesture { onSelectProduct(product) }
                    }
                }
                .padding(.horizontal, Layout.gutter)
            }
            .padding(.bottom, 16)
        }
        .background(Color.backgroundApp)
        .navigationBarHidden(true)
    }

    // A. CTA section — full-width white surface, rounded bottom corners 24
    private var ctaSection: some View {
        VStack(spacing: 14) {
            AppLogoHeader()

            // Avatar — 96pt blue gradient circle
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [Brand.gradientTop, Brand.gradientBottom],
                        startPoint: .top, endPoint: .bottom))
                    .frame(width: 96, height: 96)
                Image(systemName: "person.fill")
                    .font(.system(size: 46, weight: .regular))
                    .foregroundStyle(.white)
            }
            .padding(.top, 12)

            Text("Войдите в личный кабинет")
                .font(.screenTitle)
                .foregroundStyle(.textPrimary)
                .multilineTextAlignment(.center)

            Text("Отслеживайте заказы, копите баллы и пользуйтесь персональными скидками")
                .font(.bodyText)
                .foregroundStyle(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Layout.gutter)

            PrimaryButton("Войти или зарегистрироваться")
                .padding(.horizontal, Layout.gutter)
            SoftButton("Покупайте как юрлицо")
                .padding(.horizontal, Layout.gutter)

            (Text("Применяем ").foregroundColor(.textSecondary)
             + Text("рекомендательные технологии").foregroundColor(.brandPrimary))
                .font(.secondaryText)
                .padding(.top, 2)
        }
        .padding(.top, 8)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
        .background(
            UnevenRoundedRectangle(
                bottomLeadingRadius: Layout.cornerSheet,
                bottomTrailingRadius: Layout.cornerSheet)
                .fill(Color.surfaceCard)
                .ignoresSafeArea(edges: .top)
        )
    }

    // B. Settings group — white surface, rounded 20, hairline separators
    private var settingsSection: some View {
        VStack(spacing: 0) {
            ForEach(Array(viewModel.settings.enumerated()), id: \.element.id) { index, item in
                SettingsRow(item: item, showDivider: index < viewModel.settings.count - 1)
            }
        }
        .background(Color.surfaceCard, in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ProfileScreen(viewModel: ProfileViewModel(repository: SampleDataRepository()),
                  onSelectProduct: { _ in })
}
