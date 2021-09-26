import XCTest
@testable import SBTest

class MoviesInteractorTest: XCTestCase {
    var sut: MovieListInteractor?
    let presenter = MoviesListPresenterMock()
    let service = MovieServiceMock()
    
    override func setUp() {
        sut = MovieListInteractor(presenter: presenter, service: service)
    }
    func testSuccessFetchMovie() {
        sut?.fetchMovieList()
        XCTAssertTrue(service.isRequestMovieListCalled)
    }
    
    func testFailureFetchMovie() {
        #warning("implement this unit test")
    }
    
    func testAssertData() {
        service.requestMovieList { result in
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList)
            default:
                break
            }
        }
    }
}
