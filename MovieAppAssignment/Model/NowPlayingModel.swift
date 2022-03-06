//
//  NowPlayingModel.swift
//  MovieAppAssignment
//
//  Created by Mac on 04/03/22.
//

import Foundation

//Now playing object
struct NowPlaying: Codable {
    let results: [Result]
}

struct Result: Codable {
    let backdrop_path: String
    let overview: String
    let poster_path: String
    let release_date: String
    let title: String
    let vote_average: Double
}

//trailer videos object
struct TrailerData: Codable {
    let results: [TrailerResult]
}

struct TrailerResult: Codable {
    let key: String
}
