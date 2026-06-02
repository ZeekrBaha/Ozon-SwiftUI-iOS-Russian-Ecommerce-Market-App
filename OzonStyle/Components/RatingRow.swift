import SwiftUI

// Rating + review count with Russian pluralization (design.md §3.4).
struct RatingRow: View {
    let rating: Double
    let reviewCount: Int

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundStyle(.ratingStar)
            Text(ratingText)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.textPrimary)
            Image(systemName: "bubble.left")
                .font(.system(size: 12))
                .foregroundStyle(.textSecondary)
            Text("\(reviewCount) \(reviewWord)")
                .font(.secondaryText)
                .foregroundStyle(.textSecondary)
        }
    }

    private var ratingText: String {
        String(format: "%.1f", rating)
    }

    // 1→отзыв, 2–4→отзыва, else→отзывов; ru teen exception 11–14→отзывов.
    private var reviewWord: String {
        let n = reviewCount
        let mod100 = n % 100
        if (11...14).contains(mod100) { return "отзывов" }
        switch n % 10 {
        case 1:        return "отзыв"
        case 2, 3, 4:  return "отзыва"
        default:       return "отзывов"
        }
    }
}
