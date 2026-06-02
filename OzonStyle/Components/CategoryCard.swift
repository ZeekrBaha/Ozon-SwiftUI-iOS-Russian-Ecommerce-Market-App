import SwiftUI

// Category tile (design.md §3.6). Label top-left, image bleeds lower-right.
struct CategoryCard: View {
    let category: Category

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.searchFill
            ProductImage(name: category.imageName, contentMode: .fit)
                .frame(width: 64, height: 64)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(8)
            Text(category.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(12)
        }
        .frame(height: 132)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
