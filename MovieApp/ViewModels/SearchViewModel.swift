//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by rentamac on 2/5/26.
//

import Foundation
import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiKey: String
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Read API key from Keychain
        //self.apiKey = KeychainManager.shared.read(key: "TMDB_API_KEY") ?? ""
        self.apiKey = KeychainManager.get(account: "TMDB_API_KEY") ?? ""
        setupSearchDebounce()

    }
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                Task {
                    await self.searchMovies()
                }
            }
            .store(in: &cancellables)
    }


    func searchMovies() async {
//        guard !searchText.isEmpty else {
//            movies = []
//            return
//        }
        print("API CALLED WITH:",searchText)
        guard searchText.count >= 2 else {
                movies = []
                return
            }


        isLoading = true
        errorMessage = nil

        let url = Endpoints.searchMovie(
            query: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "",
            apiKey: apiKey
        )

        do {
            let response: SearchResponse = try await APIClient.shared.request(urlString: url)
            movies = response.results
        } catch {
            errorMessage = error.localizedDescription
            movies = []
        }

        isLoading = false
    }
}
struct TMDBImage {
    static let baseURL = "https://image.tmdb.org/t/p/"

    static func posterURL(path: String, size: String = "w185") -> URL? {
        URL(string: baseURL + size + path)
    }
}
