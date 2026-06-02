import SwiftUI

enum SearchTrailing {
    case barcode, camera
    var symbol: String {
        switch self {
        case .barcode: return "barcode.viewfinder"
        case .camera:  return "camera"
        }
    }
}

// Non-interactive search bar (design.md §3.1). Height 52, radius 14.
struct SearchBar: View {
    var fill: Color = .searchFill
    var trailing: [SearchTrailing] = []

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(.textSecondary)
            Text("Искать на Ozon")
                .font(.bodyText)
                .foregroundStyle(.textSecondary)
            Spacer(minLength: 0)
            ForEach(Array(trailing.enumerated()), id: \.offset) { _, item in
                Image(systemName: item.symbol)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(.textSecondary)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(fill, in: RoundedRectangle(cornerRadius: Layout.cornerSearch))
    }
}

#Preview {
    VStack(spacing: 12) {
        SearchBar(fill: .white, trailing: [.barcode, .camera])
        SearchBar(trailing: [.camera])
    }
    .padding()
    .background(Color.brandPrimary)
}
