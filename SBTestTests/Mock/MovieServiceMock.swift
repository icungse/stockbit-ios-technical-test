//
//  MovieServiceMock.swift
//  SBTestTests
//
//  Created by icung on 27/09/21.
//
@testable import SBTest

class MovieServiceMock: IMovieService {
    var isRequestMovieListCalled = false
    var isLoadMoreMoviesCalled = false
    
    private let mockResponse = MovieList(
        result: [Movie(
                    title: "James Bond",
                    thumbnailPotrait: "dummy.url",
                    rating: "4.2",
                    detail: Detail(
                        release: "2016",
                        description: "dummy desc",
                        country: "UK",
                        thumbnailLandscape: "dummy.url",
                        genre: "Action"
                    ))], page: "1"
    )
    
    func requestMovieList(completion: ((Result<MovieList, ErrorResult>) -> Void)?) {
        isRequestMovieListCalled = true
        completion!(.success(mockResponse))
    }
    
    func loadMoreMovies(page: Int, completion: ((Result<MovieList, ErrorResult>) -> Void)?) {
        isLoadMoreMoviesCalled = true
        completion!(.success(mockResponse))
    }
}
