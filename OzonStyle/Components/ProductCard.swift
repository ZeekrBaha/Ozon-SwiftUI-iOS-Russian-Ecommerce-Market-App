import SwiftUI

enum ProductCardVariant {
    case grid, featuredCompact, viewedGrid
}

// The keystone card (design.md §3.2, red-line #7). One component renders every
// product surface. All variants share identical internal layout; only the outer
// width container differs (the screen wraps `.featuredCompact` in HStack+Spacer).
struct ProductCard: View {
    let product: Product
    var variant: ProductCardVariant = .grid

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageBlock
            PriceBlock(product: product)
            Text(product.title)
                .font(.cardTitle)
                .foregroundStyle(.textPrimary)
                .lineLimit(2, reservesSpace: true)
                .multilineTextAlignment(.leading)
            RatingRow(rating: product.rating, reviewCount: product.reviewCount)
            CTAButton(date: product.deliveryDate)
        }
        .padding(10)
        .background(.surfaceCard, in: RoundedRectangle(cornerRadius: Layout.cornerCard))
        // Expose the whole card as one tappable element for UI tests / VoiceOver.
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityIdentifier("productCard")
    }

    private var imageBlock: some View {
        ProductImage(name: product.imageName)
            .frame(maxWidth: .infinity)
            .aspectRatio(1.0, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: Layout.cornerImage))
            .overlay(alignment: .topTrailing) { heart }
            .overlay(alignment: .bottomLeading) { badge }
            .overlay(alignment: .bottom) { dots }
    }

    private var heart: some View {
        ZStack {
            Circle()
                .fill(.white.opacity(product.isFavorite ? 0.0 : 0.85))
                .frame(width: 30, height: 30)
            Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(product.isFavorite ? Color.priceSale : Color.white)
                .shadow(color: .black.opacity(product.isFavorite ? 0 : 0.15), radius: 1)
        }
        .padding(8)
    }

    @ViewBuilder
    private var badge: some View {
        if product.badge == .salesOfWeek {
            HStack(spacing: 4) {
                Image(systemName: "flame.fill")
                    .font(.system(size: 10, weight: .bold))
                Text("СКИДКИ НЕДЕЛИ")
                    .font(.badge)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(.priceSale, in: Capsule())
            .padding(8)
        }
    }

    @ViewBuilder
    private var dots: some View {
        if product.imageCount > 1 {
            HStack(spacing: 4) {
                ForEach(0..<min(product.imageCount, 8), id: \.self) { i in
                    Circle()
                        .fill(i == 0 ? Color.brandPrimary : Color.white.opacity(0.7))
                        .frame(width: 5, height: 5)
                }
            }
            .padding(6)
            .padding(.bottom, 2)
        }
    }
}

#Preview {
    ScrollView {
        HStack(alignment: .top, spacing: 12) {
            ProductCard(product: SampleData.watch)
            ProductCard(product: SampleData.pedicure)
        }
        .padding()
    }
    .background(Color.backgroundApp)
}
