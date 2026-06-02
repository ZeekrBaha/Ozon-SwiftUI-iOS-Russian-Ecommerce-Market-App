import SwiftUI

// Price stack (design.md §3.3).
struct PriceBlock: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            // Line 1 — installment (orange)
            Text("\(product.installmentPrice) \(product.installmentTerm)")
                .font(.installment)
                .foregroundStyle(.priceInstallment)

            // Line 2 — sale price + old price + discount (stays on one line)
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(product.salePrice)
                    .font(.priceMain)
                    .foregroundStyle(.priceSale)
                    .fixedSize()
                if let old = product.oldPrice {
                    Text(old)
                        .font(.secondaryText)
                        .foregroundStyle(.textSecondary)
                        .strikethrough(true, color: .textSecondary)
                }
                if let pct = product.discountPercent {
                    Text("-\(pct)%")
                        .font(.secondaryText)
                        .foregroundStyle(.priceSale)
                        .fixedSize()
                }
            }
            .lineLimit(1)
            .minimumScaleFactor(0.7)

            // Line 3 — urgency
            if let urgency = product.urgency {
                Text(urgency)
                    .font(.secondaryText)
                    .foregroundStyle(.priceSale)
            }
        }
    }
}
