//
//  Networking.swift
//  tvexplorer (iOS)
//
//  Created by Paulo Baltieri on 16/06/2022.
//

import Foundation
import UIKit


class Networking: ObservableObject {
    @Published var results = [TVSeries]()
    
    enum NetworkError: Error {
        case invalidServerResponse
        case basRequest
        case internalServerError
    }
    
    func fetchTVShowData(_ url: URL) async throws {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.internalServerError
        }
        let decodedResponse = try JSONDecoder().decode([TVSeries].self, from: data)
        self.results = decodedResponse
        print(results)
    }
    
    func fetchPosterImage(url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let posterImage = UIImage(data: data) else {
            throw NetworkError.basRequest
        }
        return posterImage
    }
}
