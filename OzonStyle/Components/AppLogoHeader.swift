import SwiftUI

// Centered brand pill (architecture.md §6, red-line #1).
// Pill height 30, reads pill/wordmark colors from Brand. Caller is responsible
// for safe-area top spacing (= safeAreaTop + 8); see `topPadded`.
struct AppLogoHeader: View {
    var body: some View {
        Text(Brand.wordmark)
            .font(.system(size: 15, weight: .heavy))
            .foregroundStyle(Brand.wordmarkColor)
            .tracking(0.5)
            .padding(.horizontal, 14)
            .frame(height: 30)
            .background(Brand.pillColor, in: Capsule())
            .accessibilityIdentifier("brandPill")
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    VStack {
        AppLogoHeader()
        Spacer()
    }
    .padding(.top, 8)
    .background(Color.backgroundApp)
}
