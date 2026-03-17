//
//  MarketplaceTabView.swift
//  Private Payroll
//
//  Aba 3: Marketplace.
//

import SwiftUI

struct MarketplaceTabView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerSection
                categoriesSection
                highlightsSection
            }
            .padding(.bottom, 32)
            .fadeInUp()
        }
        .background(MarketplaceStyle.background)
        .ignoresSafeArea(edges: .top)
    }

    private var headerSection: some View {
        HStack {
            Text("Marketplace")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(MarketplaceStyle.textPrimary)
            Spacer()
            Button { } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18))
                    .foregroundStyle(NuDS.Color.accentPrimary)
            }
        }
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.top, 12)
        .padding(.bottom, 20)
        .background(MarketplaceStyle.surface)
    }

    private var categoriesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                categoryPill("Eletrônicos")
                categoryPill("Casa")
                categoryPill("Moda")
                categoryPill("Descontos")
            }
            .padding(.horizontal, NuDS.Spacing.lg)
        }
        .padding(.vertical, 16)
        .background(MarketplaceStyle.surface)
    }

    private func categoryPill(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(NuDS.Color.contentDefault)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(MarketplaceStyle.surfaceSubtle, in: Capsule())
    }

    private var highlightsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Em destaque")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(MarketplaceStyle.textPrimary)
                .padding(.horizontal, NuDS.Spacing.lg)

            VStack(spacing: 12) {
                marketplaceCard(icon: "bag.fill", title: "Ofertas do dia", subtitle: "Até 50% off")
                marketplaceCard(icon: "gift.fill", title: "Cashback", subtitle: "Ganhe de volta em compras")
            }
            .padding(.horizontal, NuDS.Spacing.lg)
        }
        .padding(.top, 24)
    }

    private func marketplaceCard(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(NuDS.Color.accentPrimary.opacity(0.15))
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundStyle(NuDS.Color.accentPrimary)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(MarketplaceStyle.textPrimary)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundStyle(NuDS.Color.contentSecondary)
        }
        .padding(NuDS.Spacing.lg)
        .background(MarketplaceStyle.surface, in: RoundedRectangle(cornerRadius: 16))
    }
}

private enum MarketplaceStyle {
    static let background = NuDSSemantic.Background.subtle
    static let surface = NuDSSemantic.Surface.default
    static let surfaceSubtle = NuDSSemantic.Surface.subtle
    static let textPrimary = NuDSSemantic.Content.default
}

struct MarketplaceTabView_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceTabView()
    }
}
