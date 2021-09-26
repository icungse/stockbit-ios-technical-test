//
//  MoviesPresenter.swift
//  SBTest
//
//  Created by Stockbit on 06/08/21.
//

import Foundation

protocol IMoviesPresenter {
    func presentSuccessGetMovieList(movieList: MovieList)
}

class MoviesListPresenter: IMoviesPresenter {
    // MARK: Private
    private weak var view: IMoviesViewController?
    
    init(view: IMoviesViewController) {
        self.view = view
    }

    // MARK: Internal

    func presentSuccessGetMovieList(movieList: MovieList) {
        view?.displaySuccesGetMoviesList(movieList: movieList)
    }
}
