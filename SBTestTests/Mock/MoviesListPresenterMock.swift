//
//  MoviesListPresenterMock.swift
//  SBTestTests
//
//  Created by icung on 27/09/21.
//

@testable import SBTest

class MoviesListPresenterMock : IMoviesPresenter {
    var presentSuccessGetMovieListCalled = false
    
    func presentSuccessGetMovieList(movieList : MovieList){
        presentSuccessGetMovieListCalled = true
    }
}
