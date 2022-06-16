//
//  Networking.swift
//  tvexplorer (iOS)
//
//  Created by Paulo Baltieri on 16/06/2022.
//

import Foundation


class Networking: ObservableObject {
    @Published var results = [TVSeries]()
    func requestTVShow(name: String) async {
        guard let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(name)") else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([TVSeries].self, from: data) {
                DispatchQueue.main.async {
                    self.results = decodedResponse
                }
            }
        } catch {
            print("Invalid Data")
        }
    }
}
