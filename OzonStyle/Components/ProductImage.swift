import SwiftUI

// Image with placeholder fallback (architecture.md §6, F6).
// Renders the asset when present; otherwise a searchFill tile with a `photo`
// glyph — never blank or a crash.
struct ProductImage: View {
    let name: String
    var contentMode: ContentMode = .fill

    private var assetExists: Bool { UIImage(named: name) != nil }

    var body: some View {
        if assetExists {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } else {
            ZStack {
                Color.searchFill
                Image(systemName: "photo")
                    .font(.system(size: 28, weight: .regular))
                    .foregroundStyle(.textSecondary)
            }
        }
    }
}

#Preview {
    ProductImage(name: "definitely_missing_asset")
        .frame(width: 160, height: 160)
        .clipShape(RoundedRectangle(cornerRadius: Layout.cornerImage))
        .padding()
}
