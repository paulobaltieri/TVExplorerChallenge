//
//  TVSeriesModel.swift
//  tvexplorer (iOS)
//
//  Created by Paulo Baltieri on 16/06/2022.
//

import Foundation

struct TVSeries: Decodable, Identifiable {
    var id = UUID()
    var score: Float
    var show: TVShow
}

struct TVShow: Decodable {
    var name: String?
    var summary: String?
    var image: Image?
    var rating: Rating?
    var status: String?
}

struct Rating: Decodable {
    var average: Double
}

struct Image: Decodable {
    var medium: String?
    var original: String?
}

