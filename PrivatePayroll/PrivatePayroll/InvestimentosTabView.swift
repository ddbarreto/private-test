//
//  InvestimentosTabView.swift
//  Private Payroll
//
//  Aba 4: Investimentos.
//

import SwiftUI

struct InvestimentosTabView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerSection
                totalSection
                productsSection
            }
            .padding(.bottom, 32)
        }
        .background(InvestimentosStyle.background)
        .ignoresSafeArea(edges: .top)
    }

    private var headerSection: some View {
        HStack {
            Text("Investimentos")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(InvestimentosStyle.textPrimary)
            Spacer()
            Button { } label: {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 18))
                    .foregroundStyle(NuDS.Color.accentPrimary)
            }
        }
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.top, 12)
        .padding(.bottom, 20)
        .background(InvestimentosStyle.surface)
    }

    private var totalSection: some View {
        VStack(spacing: 8) {
            Text("Saldo total")
                .font(.system(size: 13))
                .foregroundStyle(NuDS.Color.contentSecondary)
            Text("R$ 0,00")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(InvestimentosStyle.textPrimary)
            Text("▲ Comece a investir")
                .font(.system(size: 13))
                .foregroundStyle(InvestimentosStyle.positive)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(NuDS.Color.accentPrimary.opacity(0.1), in: RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.top, 8)
        .padding(.bottom, 24)
    }

    private var productsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Produtos")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(InvestimentosStyle.textPrimary)
                .padding(.horizontal, NuDS.Spacing.lg)

            VStack(spacing: 0) {
                productRow(icon: "building.columns.fill", title: "RDC", subtitle: "Renda fixa", rate: "CDI + 0%")
                Rectangle().fill(InvestimentosStyle.divider).frame(height: 1).padding(.leading, 64)
                productRow(icon: "chart.pie.fill", title: "Fundos", subtitle: "Diversificação", rate: "Variável")
            }
            .background(InvestimentosStyle.surface, in: RoundedRectangle(cornerRadius: 16))
        }
        .padding(.horizontal, NuDS.Spacing.lg)
    }

    private func productRow(icon: String, title: String, subtitle: String, rate: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(NuDS.Color.accentPrimary.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(NuDS.Color.accentPrimary)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(InvestimentosStyle.textPrimary)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            Spacer()
            Text(rate)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(NuDS.Color.accentPrimary)
        }
        .padding(NuDS.Spacing.lg)
    }
}

private enum InvestimentosStyle {
    static let background = SwiftUI.Color(hex: "F5F5F7")
    static let surface = SwiftUI.Color.white
    static let textPrimary = SwiftUI.Color(hex: "000000")
    static let positive = SwiftUI.Color(hex: "34C759")
    static let divider = SwiftUI.Color(hex: "E5E5EA")
}

private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default: (r, g, b) = (0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}

struct InvestimentosTabView_Previews: PreviewProvider {
    static var previews: some View {
        InvestimentosTabView()
    }
}
