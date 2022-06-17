//
//  TVSeriesModel.swift
//  tvexplorer (iOS)
//
//  Created by Paulo Baltieri on 16/06/2022.
//

import Foundation

struct TVSeries: Codable, Identifiable {
    var id = UUID()
    var show: TVShow
    var score: Float
    private enum CodingKeys: String, CodingKey { case score, show }
}

struct TVShow: Codable {
    var name: String?
    var summary: String?
    var image: Image?
    var rating: Rating?
    var status: String?
}

struct Rating: Codable {
    var average: Double
}

struct Image: Codable {
    var medium: String?
    var original: String?
}

