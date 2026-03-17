//
//  VisaoGeralTabView.swift
//  Private Payroll
//
//  Home screen no estilo NuDS: header roxo, Conta, ações, Meus cartões, empréstimo, Cartão de crédito, barra inferior.
//

import SwiftUI

struct VisaoGeralTabView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 0) {
                    headerRoxoSection
                    contaSection
                    quickActionsSection
                    meusCartoesSection
                    emprestimoCardSection
                    cartaoCreditoSection
                    Color.clear.frame(height: 88)
                }
                .padding(.bottom, 24)
                .fadeInUp()
            }
            .background(NuDS.Color.backgroundSecondary)
            .ignoresSafeArea(edges: .top)

            bottomBarSection
        }
    }

    // MARK: - Header roxo (NuDS TopBar / background.accent.primary)
    private var headerRoxoSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: NuDS.Spacing.s2) {
                    ZStack {
                        Circle()
                            .fill(NuDS.Color.contentOnColor.opacity(0.3))
                            .frame(width: 48, height: 48)
                        Image(systemName: "person.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(NuDS.Color.contentOnColor)
                    }
                    NuDSText(text: "Olá, Maria", variant: .subtitleMediumStrong, tone: .inverse)
                }
                Spacer()
                HStack(spacing: NuDS.Spacing.s2) {
                    Button { } label: {
                        Image(systemName: "eye")
                            .font(.system(size: 20))
                            .foregroundStyle(NuDS.Color.contentOnColor)
                    }
                    Button { } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 20))
                            .foregroundStyle(NuDS.Color.contentOnColor)
                    }
                    Button { } label: {
                        Image(systemName: "envelope.badge")
                            .font(.system(size: 20))
                            .foregroundStyle(NuDS.Color.contentOnColor)
                    }
                }
            }
            .padding(.horizontal, NuDS.Spacing.s6)
            .padding(.top, NuDS.Spacing.s3)
            .padding(.bottom, NuDS.Spacing.s6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(NuDS.Color.accentPrimary)
    }

    // MARK: - Conta (NuDS ListRow-style: título + saldo + chevron)
    private var contaSection: some View {
        VStack(alignment: .leading, spacing: NuDS.Spacing.s3) {
            HStack {
                NuDSText(text: "Conta", variant: .labelSmallStrong, tone: .primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            NuDSText(text: "R$ 1.356,98", variant: .titleSmall, tone: .primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(NuDS.Spacing.s5)
        .background(NuDS.Color.surfaceDefault)
    }

    // MARK: - Ações rápidas (NuDS spacing + typography)
    private var quickActionsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: NuDS.Spacing.s6) {
                quickActionCircle(icon: "bolt.fill", label: "Pix")
                quickActionCircle(icon: "arrow.up.arrow.down", label: "Transferir")
                quickActionCircle(icon: "banknote", label: "Pegar empréstimo")
                quickActionCircle(icon: "barcode.viewfinder", label: "Pagar")
            }
            .padding(.horizontal, NuDS.Spacing.s6)
        }
        .padding(.vertical, NuDS.Spacing.s4)
        .background(NuDS.Color.surfaceDefault)
    }

    private func quickActionCircle(icon: String, label: String) -> some View {
        VStack(spacing: NuDS.Spacing.s3) {
            ZStack {
                Circle()
                    .fill(NuDS.Color.surfaceSubtle)
                    .frame(width: 72, height: 72)
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundStyle(NuDS.Color.contentDefault)
            }
            NuDSText(text: label, variant: .labelSmallStrong, tone: .primary, lineLimit: 1)
                .multilineTextAlignment(.center)
                .frame(width: 80)
        }
        .frame(width: 80)
    }

    // MARK: - Meus cartões (NuDS ListRow com leading ícone)
    private var meusCartoesSection: some View {
        VStack(spacing: 0) {
            NuDSListRow(
                label: "Meus cartões",
                leading: {
                    AnyView(
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(NuDS.Color.contentDefault)
                    )
                },
                showChevron: true,
                onPress: { }
            )
        }
        .padding(.horizontal, NuDS.Spacing.s6)
        .padding(.top, NuDS.Spacing.s2)
        .padding(.bottom, NuDS.Spacing.s4)
        .background(NuDS.Color.surfaceDefault)
    }

    // MARK: - Card empréstimo (NuDS CalloutBox-style: surface.subtle, radius.lg)
    private var emprestimoCardSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            NuDSText(
                text: "Você tem R$ 12.300,00 disponíveis para empréstimo.",
                variant: .paragraphSmallStrong,
                tone: .primary
            )
            .padding(NuDS.Spacing.s6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(NuDS.Color.surfaceSubtle, in: RoundedRectangle(cornerRadius: NuDS.Radius.lg))
        .padding(.horizontal, NuDS.Spacing.s6)
        .padding(.bottom, NuDS.Spacing.s6)
        .background(NuDS.Color.surfaceDefault)
    }

    // MARK: - Cartão de crédito (NuDS SectionTitle + typography)
    private var cartaoCreditoSection: some View {
        VStack(alignment: .leading, spacing: NuDS.Spacing.s3) {
            NuDSSectionTitle(
                title: "Cartão de crédito",
                trailing: {
                    AnyView(
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(NuDS.Color.contentSecondary)
                    )
                },
                onTrailingPress: { }
            )
            VStack(alignment: .leading, spacing: NuDS.Spacing.s1) {
                NuDSText(text: "Fatura atual", variant: .labelXSmallDefault, tone: .secondary)
                NuDSText(text: "R$ 1.094,80", variant: .titleXSmall, tone: .primary)
                NuDSText(text: "Limite disponível: R$ 730,00", variant: .labelXSmallDefault, tone: .secondary)
            }
            .padding(.horizontal, NuDS.Spacing.s5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, NuDS.Spacing.s5)
        .background(NuDS.Color.surfaceDefault)
    }

    // MARK: - Barra inferior (NuDS BottomBar-style: radius.xl, surface.default)
    private var bottomBarSection: some View {
        HStack(spacing: 0) {
            Image(systemName: "gift")
                .font(.system(size: 22))
                .foregroundStyle(NuDS.Color.contentDefault)
            Spacer()
            ZStack {
                Circle()
                    .fill(NuDS.Color.accentPrimary)
                    .frame(width: 56, height: 56)
                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(NuDS.Color.contentOnColor)
            }
            Spacer()
            HStack(spacing: NuDS.Spacing.s5) {
                Image(systemName: "dollarsign.circle")
                    .font(.system(size: 22))
                    .foregroundStyle(NuDS.Color.contentDefault)
                Image(systemName: "bag")
                    .font(.system(size: 22))
                    .foregroundStyle(NuDS.Color.contentDefault)
            }
            NuDSText(text: "R$ 83,27", variant: .labelSmallStrong, tone: .primary)
                .padding(.leading, NuDS.Spacing.s2)
        }
        .padding(.horizontal, NuDS.Spacing.s6)
        .padding(.vertical, NuDS.Spacing.s4)
        .background(
            NuDS.Color.surfaceDefault.opacity(0.96),
            in: RoundedRectangle(cornerRadius: NuDS.Radius.xl)
        )
        .padding(.horizontal, NuDS.Spacing.s4)
        .padding(.bottom, NuDS.Spacing.s6)
        .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: -4)
    }
}

struct VisaoGeralTabView_Previews: PreviewProvider {
    static var previews: some View {
        VisaoGeralTabView()
    }
}
