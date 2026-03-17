//
//  CalculadoraConsignadoView.swift
//  Private Payroll
//
//  Tela 2: Calculadora de consignado privado.
//

import SwiftUI

struct CalculadoraConsignadoView: View {
    @State private var valorEmprestimo: String = ""
    @State private var numeroParcelas: Int = 24
    @State private var taxaMensal: Double = 1.99
    @FocusState private var valorFocused: Bool

    private var valorNumerico: Double {
        Double(valorEmprestimo.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    private var parcelaEstimada: Double {
        guard valorNumerico > 0, numeroParcelas > 0 else { return 0 }
        let taxa = taxaMensal / 100
        if taxa == 0 { return valorNumerico / Double(numeroParcelas) }
        let coef = (pow(1 + taxa, Double(numeroParcelas)) * taxa) / (pow(1 + taxa, Double(numeroParcelas)) - 1)
        return valorNumerico * coef
    }

    private var totalPago: Double {
        parcelaEstimada * Double(numeroParcelas)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NuDS.Spacing.lg) {
                NuDSListTitle(title: "Simule sua parcela")
                    .padding(.top, NuDS.Spacing.sm)

                // Valor do empréstimo
                VStack(alignment: .leading, spacing: NuDS.Spacing.xs) {
                    Text("Valor desejado (R$)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(NuDS.Color.contentSecondary)
                    TextField("0,00", text: $valorEmprestimo)
                        .keyboardType(.decimalPad)
                        .font(.system(size: 18, weight: .medium))
                        .padding(NuDS.Spacing.md)
                        .background(NuDS.Color.surfaceSubtle, in: RoundedRectangle(cornerRadius: NuDS.Radius.card))
                        .focused($valorFocused)
                }

                // Número de parcelas
                VStack(alignment: .leading, spacing: NuDS.Spacing.xs) {
                    Text("Número de parcelas")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(NuDS.Color.contentSecondary)
                    Picker("Parcelas", selection: $numeroParcelas) {
                        Text("12").tag(12)
                        Text("24").tag(24)
                        Text("36").tag(36)
                        Text("48").tag(48)
                        Text("60").tag(60)
                    }
                    .pickerStyle(.segmented)
                }

                // Taxa (informativo)
                HStack {
                    Text("Taxa mensal (exemplo)")
                        .font(.system(size: 14))
                        .foregroundStyle(NuDS.Color.contentSecondary)
                    Spacer()
                    Text(String(format: "%.2f%%", taxaMensal))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(NuDS.Color.contentDefault)
                }
                .padding(.vertical, NuDS.Spacing.xs)

                if valorNumerico > 0 {
                    NuDSCard {
                        VStack(alignment: .leading, spacing: NuDS.Spacing.md) {
                            HStack {
                                Text("Parcela estimada")
                                    .font(.system(size: 15))
                                    .foregroundStyle(NuDS.Color.contentSecondary)
                                Spacer()
                                Text(formatarMoeda(parcelaEstimada))
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(NuDS.Color.accentPrimary)
                            }
                            Rectangle()
                                .fill(NuDS.Color.surfaceSubtle)
                                .frame(height: 1)
                            HStack {
                                Text("Total a pagar")
                                    .font(.system(size: 14))
                                    .foregroundStyle(NuDS.Color.contentSecondary)
                                Spacer()
                                Text(formatarMoeda(totalPago))
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundStyle(NuDS.Color.contentDefault)
                            }
                        }
                    }
                    .padding(.horizontal, 0)
                }

                Text("Valores apenas ilustrativos. Condições sujeitas à análise de crédito.")
                    .font(.system(size: 12))
                    .foregroundStyle(NuDS.Color.contentSecondary)
            }
            .padding(NuDS.Spacing.lg)
            .frame(maxWidth: .infinity, alignment: .leading)
            .screenEnter()
        }
        .background(NuDS.Color.backgroundSecondary)
        .navigationTitle("Calculadora")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formatarMoeda(_ valor: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: valor)) ?? "R$ 0,00"
    }
}

struct CalculadoraConsignadoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CalculadoraConsignadoView()
        }
    }
}
