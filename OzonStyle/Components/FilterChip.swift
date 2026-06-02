import SwiftUI

// Filter / sort chips (design.md §3.7). Capsule, searchFill, height 42, inert.

struct SortChip: View {
    var body: some View {
        Image(systemName: "arrow.up.arrow.down")
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(.textPrimary)
            .frame(width: 42, height: 42)
            .background(.searchFill, in: Circle())
    }
}

struct FilterChip: View {
    enum Kind { case filters, brand }
    let kind: Kind

    var body: some View {
        HStack(spacing: 6) {
            if kind == .filters {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 16, weight: .regular))
            }
            Text(title)
                .font(.system(size: 15, weight: .regular))
        }
        .foregroundStyle(.textPrimary)
        .padding(.horizontal, 16)
        .frame(height: 42)
        .background(.searchFill, in: Capsule())
    }

    private var title: String {
        switch kind {
        case .filters: return "Фильтры"
        case .brand:   return "Бренд"
        }
    }
}
