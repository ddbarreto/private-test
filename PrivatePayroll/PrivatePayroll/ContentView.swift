//
//  ContentView.swift
//  Private Payroll
//
//  Tela principal com campo de pesquisa e contador de pesquisas.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var searchCount = 0
    @State private var searchHistory: [String] = []
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Contador de pesquisas
                VStack(spacing: 8) {
                    Text("Pesquisas realizadas")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("\(searchCount)")
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 20)

                // Campo de pesquisa
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Pesquisar em folha de pagamento...", text: $searchText)
                        .textFieldStyle(.plain)
                        .focused($isSearchFocused)
                        .onSubmit {
                            performSearch()
                        }
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(12)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 20)

                Button {
                    performSearch()
                } label: {
                    Label("Pesquisar", systemImage: "magnifyingglass")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .disabled(searchText.trimmingCharacters(in: .whitespaces).isEmpty)
                .padding(.horizontal, 20)

                // Histórico (opcional)
                if !searchHistory.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Últimas pesquisas")
                            .font(.headline)
                            .padding(.horizontal, 4)
                        List {
                            ForEach(searchHistory.reversed(), id: \.self) { term in
                                Text(term)
                            }
                        }
                        .listStyle(.plain)
                        .frame(maxHeight: 200)
                    }
                    .padding(.top, 8)
                }

                Spacer()
            }
            .padding(.top, 20)
            .navigationTitle("Private Payroll")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private func performSearch() {
        let term = searchText.trimmingCharacters(in: .whitespaces)
        guard !term.isEmpty else { return }
        searchCount += 1
        if !searchHistory.contains(term) {
            searchHistory.append(term)
        }
        isSearchFocused = false
        // Aqui você pode integrar a lógica real de busca (API, Core Data, etc.)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
