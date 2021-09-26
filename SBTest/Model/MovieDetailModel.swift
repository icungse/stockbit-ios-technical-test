//
//  MovieDetailModel.swift
//  SBTest
//
//  Created by Stockbit on 06/08/21.
//

import Foundation

struct MovieDetailModel {
    struct Response {
        var movie: Movie
    }
    
    struct ViewModel {
        var title: String
        var country: String
        var thumbnailLandscape: String
        var rating: String
        var genre: String
        var description: String
    }
}
