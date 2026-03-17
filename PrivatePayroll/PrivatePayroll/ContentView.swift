//
//  ContentView.swift
//  Private Payroll
//
//  TabView com 4 abas: Visão geral, Consignado, Marketplace, Investimentos.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            VisaoGeralTabView()
                .tabItem {
                    Label("Início", systemImage: "house.fill")
                }

            ConsignadoTabView()
                .tabItem {
                    Label("Consignado", systemImage: "doc.text.fill")
                }

            MarketplaceTabView()
                .tabItem {
                    Label("Marketplace", systemImage: "bag.fill")
                }

            InvestimentosTabView()
                .tabItem {
                    Label("Investimentos", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
        .tint(NuDS.Color.accentPrimary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
