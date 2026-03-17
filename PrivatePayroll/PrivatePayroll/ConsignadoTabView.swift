//
//  ConsignadoTabView.swift
//  Private Payroll
//
//  Aba 2: Consignado privado — simule e contrate.
//

import SwiftUI

struct ConsignadoTabView: View {
    @State private var autopayDismissed = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    topBarSection
                    heroCardSection
                    availableSection
                    payNowButtonSection
                    highlightCardSection
                    if !autopayDismissed {
                        autopayBannerSection
                    }
                    stepsSection
                }
                .padding(.bottom, 32)
            }
            .background(ConsignadoStyle.background)
            .ignoresSafeArea(edges: .top)
        }
    }

    private var topBarSection: some View {
        HStack {
            Text(formattedTime)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(ConsignadoStyle.textPrimary)
            Spacer()
            Button { } label: {
                ZStack {
                    Circle()
                        .fill(ConsignadoStyle.surface)
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
        .background(ConsignadoStyle.surface)
    }

    private var heroCardSection: some View {
        VStack(spacing: 0) {
            VStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(NuDS.Color.accentPrimary)
                        .frame(height: 64)
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(NuDS.Color.contentOnColor)
                }
                Text("Consignado privado")
                    .font(.system(size: 13))
                    .foregroundStyle(NuDS.Color.contentOnColor.opacity(0.9))
                Text("Simule e contrate")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(NuDS.Color.contentOnColor)
                Text("3 passos · Sem complicação")
                    .font(.system(size: 13))
                    .foregroundStyle(NuDS.Color.contentOnColor.opacity(0.85))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 28)
            .padding(.horizontal, NuDS.Spacing.lg)
            .background(NuDS.Color.accentPrimary, in: RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, NuDS.Spacing.lg)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
        .background(ConsignadoStyle.surface)
    }

    private var availableSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Disponível para você")
                    .font(.system(size: 15))
                    .foregroundStyle(ConsignadoStyle.textPrimary)
                Spacer()
                NavigationLink(destination: CalculadoraConsignadoView()) {
                    Text("Simular")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(NuDS.Color.accentPrimary)
                }
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(ConsignadoStyle.progressTrack)
                        .frame(height: 6)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(NuDS.Color.accentPrimary)
                        .frame(width: geo.size.width * 0.25, height: 6)
                }
            }
            .frame(height: 6)
        }
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.bottom, 20)
        .background(ConsignadoStyle.surface)
    }

    private var payNowButtonSection: some View {
        NavigationLink(destination: CalculadoraConsignadoView()) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(ConsignadoStyle.surfaceSubtle)
                        .frame(width: 44, height: 44)
                    Image(systemName: "percent")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(NuDS.Color.contentDefault)
                }
                Text("Simular minha parcela")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(NuDS.Color.contentDefault)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            .padding(.horizontal, NuDS.Spacing.lg)
            .padding(.vertical, 18)
            .background(ConsignadoStyle.surfaceSubtle, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.bottom, 20)
        .background(ConsignadoStyle.surface)
    }

    private var highlightCardSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Próximos passos")
                .font(.system(size: 15))
                .foregroundStyle(NuDS.Color.contentDefault)
            Text("3")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(NuDS.Color.contentDefault)
            Text("▲ Explicação, simulação e contrato")
                .font(.system(size: 13))
                .foregroundStyle(ConsignadoStyle.positive)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(NuDS.Spacing.lg)
        .background(ConsignadoStyle.surface, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.bottom, 20)
        .background(ConsignadoStyle.surface)
    }

    private var autopayBannerSection: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(ConsignadoStyle.surfaceSubtle)
                    .frame(width: 40, height: 40)
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 18))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            Text("Entenda o que é consignado antes de simular.")
                .font(.system(size: 14))
                .foregroundStyle(NuDS.Color.contentDefault)
            Spacer()
            Button {
                withAnimation(.easeOut(duration: 0.2)) { autopayDismissed = true }
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
        }
        .padding(NuDS.Spacing.md)
        .background(ConsignadoStyle.surfaceSubtle, in: RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, NuDS.Spacing.lg)
        .padding(.bottom, 24)
        .background(ConsignadoStyle.surface)
    }

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Passos")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(NuDS.Color.contentSecondary)
                .padding(.horizontal, NuDS.Spacing.lg)
                .padding(.bottom, 12)

            VStack(spacing: 0) {
                stepRow(icon: "book.fill", iconBg: NuDS.Color.accentPrimary, title: "Explicação", detail: "O que é consignado", destination: ExplicacaoConsignadoView())
                stepDividerLine
                stepRow(icon: "function", iconBg: NuDS.Color.contentSecondary, title: "Calculadora", detail: "Simule a parcela", destination: CalculadoraConsignadoView())
                stepDividerLine
                stepRow(icon: "doc.text.fill", iconBg: NuDS.Color.contentSecondary, title: "Contrato", detail: "Revise e assine", destination: ContratoView())
            }
            .background(ConsignadoStyle.surface, in: RoundedRectangle(cornerRadius: 16))
        }
        .padding(.horizontal, NuDS.Spacing.lg)
        .background(ConsignadoStyle.background)
    }

    private var stepDividerLine: some View {
        Rectangle()
            .fill(ConsignadoStyle.divider)
            .frame(height: 1)
            .padding(.leading, 72)
    }

    private func stepRow<D: View>(icon: String, iconBg: SwiftUI.Color, title: String, detail: String, destination: D) -> some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(iconBg.opacity(0.15))
                        .frame(width: 44, height: 44)
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundStyle(iconBg)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(NuDS.Color.contentDefault)
                    Text(detail)
                        .font(.system(size: 13))
                        .foregroundStyle(NuDS.Color.contentSecondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            .padding(.horizontal, NuDS.Spacing.lg)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }

    private var formattedTime: String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f.string(from: Date())
    }
}

private enum ConsignadoStyle {
    static let background = SwiftUI.Color(hex: "F5F5F7")
    static let surface = SwiftUI.Color.white
    static let surfaceSubtle = SwiftUI.Color(hex: "F0F0F2")
    static let textPrimary = SwiftUI.Color(hex: "000000")
    static let progressTrack = SwiftUI.Color(hex: "E5E5EA")
    static let divider = SwiftUI.Color(hex: "E5E5EA")
    static let positive = SwiftUI.Color(hex: "34C759")
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

struct ConsignadoTabView_Previews: PreviewProvider {
    static var previews: some View {
        ConsignadoTabView()
    }
}
