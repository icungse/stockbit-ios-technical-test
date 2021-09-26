//
//  MovieDetailPresenter.swift
//  MovieDetailPresenter
//
//  Created by Ari Munandar on 06/08/21.
//

import Foundation

protocol IMovieDetailPresenter: AnyObject {
    func presentMovieDetail(response: MovieDetailModel.Response)
}

class MovieDetailPresenter: IMovieDetailPresenter {
    private var view: IMovieDetailViewController?
    
    init(view: IMovieDetailViewController) {
        self.view = view
    }
    
    func presentMovieDetail(response: MovieDetailModel.Response) {
        let movieResponse = response.movie
        let viewModel = MovieDetailModel.ViewModel(
            title: movieResponse.title,
            country: movieResponse.detail.country,
            thumbnailLandscape: movieResponse.detail.thumbnailLandscape,
            rating: movieResponse.rating,
            genre: movieResponse.detail.genre,
            description: movieResponse.detail.description)
        view?.displayMovieDetail(viewModel: viewModel)
    }
}
