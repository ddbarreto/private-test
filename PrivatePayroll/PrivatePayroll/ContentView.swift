//
//  ContentView.swift
//  Private Payroll
//
//  Tela principal guiada pelo Figma: header roxo, widgets tipo Conta, pesquisa e contador.
//

import SwiftUI

// Cores do design system do Figma (NuDS)
private enum FigmaColors {
    static let accentPrimary = Color(hex: "820AD1")
    static let accentPrimarySubtle = Color(hex: "F6ECFF")
    static let surfaceDefault = Color.white
    static let surfaceSubtle = Color(hex: "EFEFEF")
    static let backgroundSecondary = Color(hex: "F0F1F5")
    static let contentDefault = Color(hex: "000000")
    static let contentSecondary = Color(hex: "727683")
    static let contentOnColor = Color.white
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var searchCount = 0
    @State private var searchHistory: [String] = []
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header roxo (estilo Figma: Home / Header)
                headerSection

                // Área branca: widget "Pesquisas" (estilo Balance Widget / Conta)
                pesquisasWidgetSection

                // Campo de pesquisa (estilo conteúdo + pill)
                searchSection

                // Histórico em lista (estilo List title + itens)
                if !searchHistory.isEmpty {
                    historicoSection
                }
            }
        }
        .background(FigmaColors.backgroundSecondary)
        .ignoresSafeArea(edges: .top)
    }

    // MARK: - Header roxo
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Circle()
                    .fill(FigmaColors.contentOnColor.opacity(0.3))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundStyle(FigmaColors.contentOnColor)
                            .font(.system(size: 22))
                    )
                Spacer()
                Image(systemName: "eye")
                    .foregroundStyle(FigmaColors.contentOnColor)
                    .font(.system(size: 20))
                Image(systemName: "questionmark.circle")
                    .foregroundStyle(FigmaColors.contentOnColor)
                    .font(.system(size: 20))
                Image(systemName: "envelope.badge")
                    .foregroundStyle(FigmaColors.contentOnColor)
                    .font(.system(size: 20))
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)
            .padding(.bottom, 8)

            Text("Olá")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(FigmaColors.contentOnColor)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(FigmaColors.accentPrimary)
    }

    // MARK: - Widget "Pesquisas realizadas" (estilo Conta / Balance)
    private var pesquisasWidgetSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Pesquisas realizadas")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(FigmaColors.contentDefault)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(FigmaColors.contentSecondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 8)

            Text("\(searchCount)")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(FigmaColors.contentDefault)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(FigmaColors.surfaceDefault)
    }

    // MARK: - Pesquisa (campo + botão, estilo pill / conteúdo)
    private var searchSection: some View {
        VStack(spacing: 16) {
            // Pill: campo de pesquisa
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(FigmaColors.contentSecondary)
                    .font(.system(size: 18))
                TextField("Pesquisar em folha de pagamento...", text: $searchText)
                    .font(.system(size: 16))
                    .focused($isSearchFocused)
                    .onSubmit { performSearch() }
                if !searchText.isEmpty {
                    Button { searchText = "" } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(FigmaColors.contentSecondary)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(FigmaColors.surfaceDefault, in: RoundedRectangle(cornerRadius: 12))

            // Botão Pesquisar (primário roxo)
            Button { performSearch() } label: {
                Text("Pesquisar")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(FigmaColors.contentOnColor)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .background(FigmaColors.accentPrimary, in: RoundedRectangle(cornerRadius: 12))
            .disabled(searchText.trimmingCharacters(in: .whitespaces).isEmpty)
            .opacity(searchText.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1)
        }
        .padding(24)
        .background(FigmaColors.surfaceDefault)
        .padding(.top, 8)
    }

    // MARK: - Histórico (estilo List title + itens com divider)
    private var historicoSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Últimas pesquisas")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(FigmaColors.contentDefault)
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 12)

            VStack(spacing: 0) {
                ForEach(Array(searchHistory.reversed().enumerated()), id: \.offset) { index, term in
                    HStack {
                        Text(term)
                            .font(.system(size: 14))
                            .foregroundStyle(FigmaColors.contentDefault)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12))
                            .foregroundStyle(FigmaColors.contentSecondary)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(FigmaColors.surfaceDefault)

                    if index < searchHistory.count - 1 {
                        Rectangle()
                            .fill(FigmaColors.surfaceSubtle)
                            .frame(height: 1)
                            .padding(.leading, 24)
                    }
                }
            }
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(FigmaColors.surfaceDefault)
        .padding(.top, 8)
    }

    private func performSearch() {
        let term = searchText.trimmingCharacters(in: .whitespaces)
        guard !term.isEmpty else { return }
        searchCount += 1
        if !searchHistory.contains(term) {
            searchHistory.append(term)
        }
        isSearchFocused = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
