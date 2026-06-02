import SwiftUI

// Full-width primary / soft buttons (design.md §3.11). Height 56, inert.

struct PrimaryButton: View {
    let title: String
    init(_ title: String) { self.title = title }

    var body: some View {
        Text(title)
            .font(.cta)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(.brandPrimary, in: RoundedRectangle(cornerRadius: Layout.cornerButtonLg))
    }
}

struct SoftButton: View {
    let title: String
    init(_ title: String) { self.title = title }

    var body: some View {
        Text(title)
            .font(.cta)
            .foregroundStyle(.brandPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(.brandPrimarySoft, in: RoundedRectangle(cornerRadius: Layout.cornerButtonLg))
    }
}
