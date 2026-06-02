import SwiftUI

// Section header (design.md §3.10). 28 bold, leading-aligned, gutter inset.
struct SectionHeader: View {
    let title: String
    init(_ title: String) { self.title = title }

    var body: some View {
        Text(title)
            .font(.sectionTitle)
            .foregroundStyle(.textPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Layout.gutter)
    }
}
