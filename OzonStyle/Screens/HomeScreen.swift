import SwiftUI
import Combine

// Screen 1 — Главная (design.md §4). Hero lives INSIDE the gradient (red-line #6).
struct HomeScreen: View {
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: Layout.cardSpacing),
        count: 2
    )

    // Carousel auto-advance. Slides left every 3s, loops.
    @State private var bannerIndex = 0
    private let bannerTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            VStack(spacing: Layout.sectionSpacing) {
                gradientHeader
                carouselBanner
                    .padding(.horizontal, Layout.gutter)
                quickActionsRail

                VStack(spacing: 12) {
                    SectionHeader("Рекомендуем")
                    LazyVGrid(columns: columns, spacing: Layout.gridSpacing) {
                        ForEach(SampleData.recommended) { product in
                            ProductCard(product: product, variant: .grid)
                        }
                    }
                    .padding(.horizontal, Layout.gutter)
                }
            }
            .padding(.bottom, 16)
        }
        .background(Color.backgroundApp)
    }

    // MARK: Gradient header (logo + city/login + search + hero, all inside gradient)

    private var gradientHeader: some View {
        VStack(spacing: 14) {
            AppLogoHeader()

            // City + login row
            HStack {
                HStack(spacing: 4) {
                    Text("Астана")
                        .font(.system(size: 17, weight: .semibold))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 13, weight: .semibold))
                }
                .foregroundStyle(.white)
                Spacer()
                Text("Войти")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 18)
                    .frame(height: 36)
                    .background(.buttonDark, in: Capsule())
            }
            .padding(.horizontal, Layout.gutter)

            SearchBar(fill: .white, trailing: [.barcode, .camera])
                .padding(.horizontal, Layout.gutter)

            hero
                .padding(.horizontal, Layout.gutter)
                .padding(.top, 4)
        }
        .padding(.top, 8)
        .padding(.bottom, 22)
        .background(
            UnevenRoundedRectangle(
                bottomLeadingRadius: Layout.cornerSheet,
                bottomTrailingRadius: Layout.cornerSheet)
                .fill(LinearGradient(
                    colors: [Color(red: 0.13, green: 0.55, blue: 1.0),
                             Color(red: 0.0,  green: 0.36, blue: 1.0)],
                    startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea(edges: .top)
        )
    }

    private var hero: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10) {
                Text("ПРАЗДНИК\nПРИЛЕТИТ")
                    .font(.system(size: 26, weight: .heavy))
                    .foregroundStyle(.white)
                    .lineSpacing(0)
                // Countdown pill on buttonDark
                HStack(spacing: 8) {
                    Text("19:45:13 до старта")
                        .font(.system(size: 14, weight: .semibold))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .frame(height: 36)
                .background(.buttonDark, in: Capsule())
            }
            Spacer()
            // Stylized "О!РАСПРОДАЖА" lockup (text, IP-safe)
            VStack(alignment: .trailing, spacing: 2) {
                Text("О!")
                    .font(.system(size: 40, weight: .black))
                Text("РАСПРОДАЖА")
                    .font(.system(size: 18, weight: .heavy))
            }
            .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: Carousel banner (4 slides, auto-advancing, dots)

    private var carouselBanner: some View {
        TabView(selection: $bannerIndex) {
            ForEach(Array(SampleData.banners.enumerated()), id: \.element.id) { i, banner in
                bannerSlide(banner).tag(i)
            }
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .tabViewStyle(.page(indexDisplayMode: .always))
        .onReceive(bannerTimer) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                bannerIndex = (bannerIndex + 1) % SampleData.banners.count
            }
        }
    }

    private func bannerSlide(_ banner: Banner) -> some View {
        let (colors, darkText) = bannerStyle(banner.style)
        return ZStack(alignment: .leading) {
            LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
            VStack(alignment: .leading, spacing: 4) {
                Text(banner.title)
                    .font(.system(size: 18, weight: .semibold))
                Text(banner.subtitle)
                    .font(.system(size: 24, weight: .heavy))
            }
            .foregroundStyle(darkText ? Color.textPrimary : .white)
            .padding(.horizontal, 20)
        }
    }

    private func bannerStyle(_ style: Int) -> ([Color], Bool) {
        switch style {
        case 1: return ([Color(red: 0.91, green: 0.93, blue: 0.96),
                         Color(red: 0.82, green: 0.85, blue: 0.90)], true)
        case 2: return ([Color(red: 0.04, green: 0.10, blue: 0.23),
                         Color(red: 0.07, green: 0.16, blue: 0.29)], false)
        case 3: return ([Color(red: 1.00, green: 0.18, blue: 0.49),
                         Color(red: 0.94, green: 0.07, blue: 0.49)], false)
        default: return ([Color(red: 0.00, green: 0.42, blue: 1.0),
                          Color(red: 0.00, green: 0.30, blue: 0.92)], false)
        }
    }

    // MARK: Quick actions rail

    private var quickActionsRail: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(SampleData.quickActions) { action in
                    QuickActionTile(action: action)
                }
            }
            .padding(.horizontal, Layout.gutter)
        }
    }
}

#Preview { HomeScreen() }
