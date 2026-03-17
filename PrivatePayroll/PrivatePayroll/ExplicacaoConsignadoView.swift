//
//  ExplicacaoConsignadoView.swift
//  Private Payroll
//
//  Tela 1: Explicação do que é um consignado privado.
//

import SwiftUI

struct ExplicacaoConsignadoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NuDS.Spacing.lg) {
                NuDSListTitle(title: "O que é consignado privado?")
                    .padding(.top, NuDS.Spacing.sm)

                Text("O empréstimo consignado privado é um crédito com parcelas descontadas direto na folha de pagamento ou no benefício (como aposentadoria ou pensão), mas oferecido por instituições privadas — não pelo governo.")
                    .font(.system(size: 15))
                    .foregroundStyle(NuDS.Color.contentDefault)
                    .lineSpacing(4)

                Text("Vantagens")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(NuDS.Color.contentDefault)

                VStack(alignment: .leading, spacing: NuDS.Spacing.sm) {
                    itemExplicacao(icon: "checkmark.circle.fill", text: "Taxas geralmente menores que empréstimo pessoal")
                    itemExplicacao(icon: "checkmark.circle.fill", text: "Desconto em folha reduz o risco de inadimplência")
                    itemExplicacao(icon: "checkmark.circle.fill", text: "Prazo pode ser maior, com parcelas no seu limite")
                    itemExplicacao(icon: "checkmark.circle.fill", text: "Processo de contratação simples e digital")
                }

                Text("Quem pode contratar")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(NuDS.Color.contentDefault)

                Text("Funcionários de empresas conveniadas (desconto em folha) ou aposentados e pensionistas (desconto no benefício pelo INSS ou instituição pagadora).")
                    .font(.system(size: 15))
                    .foregroundStyle(NuDS.Color.contentDefault)
                    .lineSpacing(4)

                Text("Na próxima etapa você pode simular o valor das parcelas na calculadora e, em seguida, conferir o contrato.")
                    .font(.system(size: 14))
                    .foregroundStyle(NuDS.Color.contentSecondary)
                    .lineSpacing(4)
                    .padding(.top, NuDS.Spacing.sm)
            }
            .padding(NuDS.Spacing.lg)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(NuDS.Color.backgroundSecondary)
        .navigationTitle("Consignado privado")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func itemExplicacao(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: NuDS.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(NuDS.Color.accentPrimary)
            Text(text)
                .font(.system(size: 15))
                .foregroundStyle(NuDS.Color.contentDefault)
        }
    }
}

struct ExplicacaoConsignadoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExplicacaoConsignadoView()
        }
    }
}
