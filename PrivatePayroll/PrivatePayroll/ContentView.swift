//
//  ContentView.swift
//  Private Payroll
//
//  TabView com 4 abas: Visão geral, Consignado, Marketplace, Investimentos.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            VisaoGeralTabView()
                .tabItem {
                    Label("Início", systemImage: "house.fill")
                }
                .tag(0)

            ConsignadoTabView()
                .tabItem {
                    Label("Consignado", systemImage: "doc.text.fill")
                }
                .tag(1)

            MarketplaceTabView()
                .tabItem {
                    Label("Marketplace", systemImage: "bag.fill")
                }
                .tag(2)

            InvestimentosTabView()
                .tabItem {
                    Label("Investimentos", systemImage: "chart.line.uptrend.xyaxis")
                }
                .tag(3)
        }
        .tint(NuDS.Color.accentPrimary)
        .animation(AppAnimations.spring, value: selectedTab)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
