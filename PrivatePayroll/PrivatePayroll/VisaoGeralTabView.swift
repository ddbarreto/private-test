//
//  VisaoGeralTabView.swift
//  Private Payroll
//
//  Aba 1: Visão geral — conta, cartão de crédito, etc.
//

import SwiftUI

struct VisaoGeralTabView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                topBarSection
                contaSection
                cartaoSection
                quickActionsSection
            }
            .padding(.bottom, 32)
        }
        .background(VisaoGeralStyle.background)
        .ignoresSafeArea(edges: .top)
    }

    private var topBarSection: some View {
        HStack {
            Text("Olá, Maria")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(VisaoGeralStyle.textPrimary)
            Spacer()
            Button { } label: {
                ZStack {
                    Circle()
                        .fill(VisaoGeralStyle.surface)
                        .frame(width: 40, height: 40)
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(NuDS.Color.accentPrimary)
                }
            }
        }
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.top, 12)
        .padding(.bottom, 20)
        .background(VisaoGeralStyle.surface)
    }

    private var contaSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Conta")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(VisaoGeralStyle.textPrimary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            Text("R$ 1.356,98")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(VisaoGeralStyle.textPrimary)
            Text("Saldo disponível")
                .font(.system(size: 13))
                .foregroundStyle(NuDS.Color.contentSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(NuDS.Spacing.lg)
        .background(VisaoGeralStyle.surface)
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }

    private var cartaoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Cartão de crédito")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(VisaoGeralStyle.textPrimary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            Text("Fatura atual")
                .font(.system(size: 13))
                .foregroundStyle(NuDS.Color.contentSecondary)
            Text("R$ 1.094,80")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(VisaoGeralStyle.textPrimary)
            Text("Limite disponível: R$ 730,00")
                .font(.system(size: 13))
                .foregroundStyle(NuDS.Color.contentSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(NuDS.Spacing.lg)
        .background(VisaoGeralStyle.surface, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.bottom, 24)
    }

    private var quickActionsSection: some View {
        HStack(spacing: NuDS.Spacing.lg) {
            quickAction(icon: "dollarsign.circle", label: "Pix")
            quickAction(icon: "arrow.up.arrow.down", label: "Transferir")
            quickAction(icon: "creditcard", label: "Cartões")
            quickAction(icon: "qrcode", label: "Pagar")
        }
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.vertical, 20)
        .background(VisaoGeralStyle.surface)
    }

    private func quickAction(icon: String, label: String) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(VisaoGeralStyle.surfaceSubtle)
                    .frame(width: 56, height: 56)
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundStyle(NuDS.Color.accentPrimary)
            }
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(VisaoGeralStyle.textPrimary)
        }
        .frame(maxWidth: .infinity)
    }
}

private enum VisaoGeralStyle {
    static let background = SwiftUI.Color(hex: "F5F5F7")
    static let surface = SwiftUI.Color.white
    static let surfaceSubtle = SwiftUI.Color(hex: "F0F0F2")
    static let textPrimary = SwiftUI.Color(hex: "000000")
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

struct VisaoGeralTabView_Previews: PreviewProvider {
    static var previews: some View {
        VisaoGeralTabView()
    }
}
