//
//  HomeViewModel.swift
//  tvexplorer (iOS)
//
//  Created by Paulo Baltieri on 16/06/2022.
//

import Foundation
import UIKit

class ViewModel: ObservableObject{
    @Published var tvSeries = [TVSeries]()
    var networking = Networking()
    
    enum dataError: Error {
        case decodingError
        case encodingError
    }
    
    func getTVShowNamed(_ title: String) async {
        guard let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(title)") else {
            return
        }
        do {
            try await networking.fetchTVShowData(url)
            networking.$results
                .receive(on: RunLoop.main)
                .assign(to: &self.$tvSeries)
                
        } catch {
            dataError.decodingError
        }
    }
    
    func getPosterImage(_ posterURL: String) async -> UIImage? {
        var posterPicture: UIImage? = nil
        guard let url = URL(string: posterURL) else {
            return nil
        }
        do {
            posterPicture = try await networking.fetchPosterImage(url: url)
        } catch {
            dataError.decodingError
        }
        return posterPicture
    }
}
