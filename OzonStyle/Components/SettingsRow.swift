import SwiftUI

// Settings list row (design.md §3.9). Height 56, value pill + chevron, hairline.
struct SettingsRow: View {
    let item: SettingsItem
    var showDivider: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Text(item.title)
                    .font(.bodyText)
                    .foregroundStyle(.textPrimary)
                Spacer(minLength: 8)
                if let value = item.value {
                    Text(value)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.textPrimary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.searchFill, in: Capsule())
                }
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.textSecondary)
            }
            .frame(height: 56)
            .padding(.horizontal, Layout.gutter)

            if showDivider {
                Rectangle()
                    .fill(Color("separator"))
                    .frame(height: 1)
                    .padding(.leading, Layout.gutter)
            }
        }
    }
}
