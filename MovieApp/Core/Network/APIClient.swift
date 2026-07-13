//
//  dummy5.swift
//  MovieApp
//
//  Created by rentamac on 2/4/26.
//

import Foundation


final class APIClient {

    static let shared = APIClient()
    private init() {}

    func request<T: Decodable>(urlString: String) async throws -> T {

        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }

        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError
        }
    }
}
