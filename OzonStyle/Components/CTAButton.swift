import SwiftUI

// In-card CTA (design.md §3.5). Full-width, height 44, inert.
struct CTAButton: View {
    let date: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "basket")
                .font(.system(size: 16, weight: .semibold))
            Text(date)
                .font(.cta)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(.brandPrimary, in: RoundedRectangle(cornerRadius: Layout.cornerButtonSm))
    }
}
