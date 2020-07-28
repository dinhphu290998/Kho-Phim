//
//  Movie.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/10/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

struct Movie: Codable {
    var popularity: Double?
    var vote_count: Int?
    var video: Bool?
    var poster_path: String?
    var id: Int?
    var adult: Bool?
    var backdrop_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var title: String?
    var vote_average: Double?
    var overview: String?
    var release_date: String?
}

class FavoriteMovie: Object {
    dynamic var popularity: Double?
    dynamic var vote_count: Int?
    dynamic var video: Bool?
    @objc dynamic var poster_path: String?
    dynamic var id: Int?
    dynamic var adult: Bool?
    @objc dynamic var backdrop_path: String?
    @objc dynamic var original_language: String?
    @objc dynamic var original_title: String?
    @objc dynamic var genre_ids: [Int]?
    @objc dynamic var title: String?
    dynamic var vote_average: Double?
    @objc dynamic var overview: String?
    @objc dynamic var release_date: String?
    
    func initFavoriteMovie(movie: Movie) {
        self.popularity = movie.popularity
        self.vote_count = movie.vote_count
        self.video = movie.video
        self.poster_path = movie.poster_path
        self.id = movie.id
        self.adult = movie.adult
        self.backdrop_path = movie.backdrop_path
        self.original_language = movie.original_language
        self.original_title = movie.original_title
        self.genre_ids = movie.genre_ids
        self.title = movie.title
        self.vote_average = movie.vote_average
        self.overview = movie.overview
        self.release_date = movie.release_date
    }
    
}
