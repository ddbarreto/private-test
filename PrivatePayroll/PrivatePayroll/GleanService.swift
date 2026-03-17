//
//  GleanService.swift
//  Private Payroll
//
//  Integração com a Search API do Glean: todo o conteúdo de pesquisa vem do Glean.
//

import Foundation

// MARK: - Configuração (preencha com o instance e token do seu Glean)
struct GleanConfig {
    /// Ex: "sua-empresa" → URL base: https://sua-empresa-be.glean.com
    static var instance: String {
        Bundle.main.object(forInfoDictionaryKey: "GLEAN_INSTANCE") as? String ?? ""
    }
    /// Token de API (Bearer). Obtenha no admin do Glean ou via OAuth.
    static var apiToken: String {
        Bundle.main.object(forInfoDictionaryKey: "GLEAN_API_TOKEN") as? String ?? ""
    }
    static var isConfigured: Bool {
        !instance.isEmpty && !apiToken.isEmpty
    }
    static var baseURL: String {
        "https://\(instance)-be.glean.com/rest/api/v1"
    }
}

// MARK: - Modelos da Search API
struct GleanSearchRequest: Encodable {
    let query: String
    let pageSize: Int
}

struct GleanSearchResponse: Decodable {
    let results: [GleanSearchResult]?
    let hasMoreResults: Bool?
    let cursor: String?
}

struct GleanSearchResult: Decodable {
    let id: String?
    let title: String?
    let url: String?
    let snippet: String?
    let datasource: String?
    let lastModified: String?
}

// MARK: - Serviço
enum GleanServiceError: Error {
    case notConfigured
    case invalidURL
    case network(Error)
    case server(Int)
    case decoding(Error)
}

@MainActor
final class GleanService: ObservableObject {
    @Published var isSearching = false
    @Published var lastError: String?

    func search(query: String, pageSize: Int = 15) async -> [GleanSearchResult] {
        lastError = nil
        guard GleanConfig.isConfigured else {
            lastError = "Glean não configurado. Adicione GLEAN_INSTANCE e GLEAN_API_TOKEN no Info.plist."
            return []
        }
        guard let url = URL(string: "\(GleanConfig.baseURL)/search") else {
            lastError = "URL do Glean inválida."
            return []
        }
        isSearching = true
        defer { isSearching = false }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(GleanConfig.apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(GleanSearchRequest(query: query, pageSize: pageSize))
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse else {
                lastError = "Resposta inválida."
                return []
            }
            guard (200...299).contains(http.statusCode) else {
                lastError = "Glean retornou \(http.statusCode). Verifique token e instance."
                return []
            }
            let decoded = try JSONDecoder().decode(GleanSearchResponse.self, from: data)
            return decoded.results ?? []
        } catch {
            lastError = error.localizedDescription
            return []
        }
    }
}
