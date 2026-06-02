import SwiftUI

// Category tile (design.md §3.6). Label top-left; product cutout fills the lower
// portion, bottom-right, `.fit` (transparent PNG over the light card).
struct CategoryCard: View {
    let category: Category

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.searchFill

            ProductImage(name: category.imageName, contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 116)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing, 8)
                .padding(.bottom, 8)

            Text(category.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(12)
        }
        .frame(height: 188)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
