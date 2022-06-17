//
//  Networking.swift
//  tvexplorer (iOS)
//
//  Created by Paulo Baltieri on 16/06/2022.
//

import Foundation


class Networking: ObservableObject {
    @Published var results = [TVSeries]()
    
    enum NetworkError: Error {
        case invalidServerResponse
        case basRequest
        case internalServerError
    }
    
    func fetchTVShowData(_ url: URL) async throws {
        // request
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.internalServerError
        }
        let decodedResponse = try JSONDecoder().decode([TVSeries].self, from: data)
        self.results = decodedResponse
    }
}
