//
//  CalculadoraSpaceView.swift
//  Private Payroll
//
//  Espaço "O que o cliente procura na calculadora" — repositório.
//

import SwiftUI

/// Itens que o cliente costuma procurar na calculadora (conteúdo do espaço).
struct CalculadoraSearchItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
}

struct CalculadoraSpaceView: View {
    private let items: [CalculadoraSearchItem] = [
        CalculadoraSearchItem(title: "Salário líquido", subtitle: "Quanto vou receber após descontos"),
        CalculadoraSearchItem(title: "Descontos (INSS, IR)", subtitle: "Valor total de impostos"),
        CalculadoraSearchItem(title: "FGTS", subtitle: "Quanto vai para o FGTS"),
        CalculadoraSearchItem(title: "Vale transporte", subtitle: "Desconto e valor do benefício"),
        CalculadoraSearchItem(title: "Horas extras", subtitle: "Como entram no cálculo"),
        CalculadoraSearchItem(title: "Férias e 13º", subtitle: "Projeção de valores"),
        CalculadoraSearchItem(title: "Rescisão", subtitle: "Cálculo de rescisão contratual"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                NuDSListTitle(title: "O que o cliente procura na calculadora")
                    .padding(.top, NuDS.Spacing.sm)

                VStack(spacing: 0) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        NuDSTileItem(title: item.title, subtitle: item.subtitle)
                        if index < items.count - 1 {
                            Rectangle()
                                .fill(NuDS.Color.surfaceSubtle)
                                .frame(height: 1)
                                .padding(.leading, NuDS.Spacing.lg)
                        }
                    }
                }
                .padding(.bottom, NuDS.Spacing.lg)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(NuDS.Color.surfaceDefault)
        }
        .background(NuDS.Color.backgroundSecondary)
        .navigationTitle("Calculadora")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CalculadoraSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CalculadoraSpaceView()
        }
    }
}
