//
//  ContratoView.swift
//  Private Payroll
//
//  Tela 3: Contrato de consignado privado.
//

import SwiftUI

struct ContratoView: View {
    @State private var aceiteTermos = false
    @State private var mostrandoConfirmacao = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NuDS.Spacing.lg) {
                NuDSListTitle(title: "Contrato de empréstimo consignado privado")
                    .padding(.top, NuDS.Spacing.sm)

                Text("Ao prosseguir, você declara que leu e concorda com as condições do empréstimo consignado privado, incluindo:")
                    .font(.system(size: 15))
                    .foregroundStyle(NuDS.Color.contentDefault)
                    .lineSpacing(4)

                VStack(alignment: .leading, spacing: NuDS.Spacing.sm) {
                    itemContrato("Valor do empréstimo e número de parcelas conforme simulação")
                    itemContrato("Desconto em folha de pagamento ou no benefício")
                    itemContrato("Taxa de juros e CET (Custo Efetivo Total) aplicáveis")
                    itemContrato("Política de privacidade e uso de dados")
                }

                Text("O contrato completo será disponibilizado para download e assinatura eletrônica conforme a legislação vigente.")
                    .font(.system(size: 14))
                    .foregroundStyle(NuDS.Color.contentSecondary)
                    .lineSpacing(4)

                Toggle(isOn: $aceiteTermos) {
                    Text("Li e aceito os termos do contrato")
                        .font(.system(size: 15))
                        .foregroundStyle(NuDS.Color.contentDefault)
                }
                .tint(NuDS.Color.accentPrimary)
                .padding(.top, NuDS.Spacing.md)

                Button(action: {
                    if aceiteTermos { mostrandoConfirmacao = true }
                }) {
                    Text("Confirmar e continuar")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(NuDS.Color.contentOnColor)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .background(aceiteTermos ? NuDS.Color.accentPrimary : NuDS.Color.surfaceSubtle, in: RoundedRectangle(cornerRadius: NuDS.Radius.card))
                .foregroundStyle(aceiteTermos ? NuDS.Color.contentOnColor : NuDS.Color.contentSecondary)
                .disabled(!aceiteTermos)
                .padding(.top, NuDS.Spacing.md)
            }
            .padding(NuDS.Spacing.lg)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(NuDS.Color.backgroundSecondary)
        .navigationTitle("Contrato")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Contrato", isPresented: $mostrandoConfirmacao) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Sua solicitação foi registrada. Em breve você receberá o contrato para assinatura.")
        }
    }

    private func itemContrato(_ text: String) -> some View {
        HStack(alignment: .top, spacing: NuDS.Spacing.sm) {
            Image(systemName: "doc.text")
                .font(.system(size: 14))
                .foregroundStyle(NuDS.Color.accentPrimary)
            Text(text)
                .font(.system(size: 14))
                .foregroundStyle(NuDS.Color.contentDefault)
        }
    }
}

struct ContratoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContratoView()
        }
    }
}
