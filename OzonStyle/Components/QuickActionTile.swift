import SwiftUI

// Quick-action rail tile (design.md §3.8). 56pt image tile + 2-line caption.
struct QuickActionTile: View {
    let action: QuickAction

    var body: some View {
        VStack(spacing: 6) {
            ProductImage(name: action.imageName, contentMode: .fill)
                .frame(width: 56, height: 56)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            Text(action.title)
                .font(.secondaryText)
                .foregroundStyle(.textPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 34, alignment: .top)
        }
        .frame(width: 72)
    }
}
