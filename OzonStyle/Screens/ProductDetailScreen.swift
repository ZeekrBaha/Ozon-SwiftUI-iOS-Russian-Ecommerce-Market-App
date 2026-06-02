import SwiftUI

// Product detail — the pushed destination for `AppRoute.productDetail`. No
// reference screenshot exists for this screen (it is outside the 5 mocked
// surfaces); it deliberately reuses the existing product components so the
// coordinator has a real destination to navigate to.
struct ProductDetailScreen: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ProductImage(name: product.imageName, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1.0, contentMode: .fit)
                    .background(Color.surfaceCard, in: RoundedRectangle(cornerRadius: Layout.cornerImage))

                PriceBlock(product: product)

                Text(product.title)
                    .font(.sectionTitle)
                    .foregroundStyle(.textPrimary)
                    .multilineTextAlignment(.leading)

                RatingRow(rating: product.rating, reviewCount: product.reviewCount)

                if let urgency = product.urgency {
                    Text(urgency)
                        .font(.secondaryText)
                        .foregroundStyle(.priceSale)
                }

                CTAButton(date: product.deliveryDate)
            }
            .padding(Layout.gutter)
        }
        .background(Color.backgroundApp)
        .navigationTitle("Товар")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ProductDetailScreen(product: SampleData.watch)
    }
}
