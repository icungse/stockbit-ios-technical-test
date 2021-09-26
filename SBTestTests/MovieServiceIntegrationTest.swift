
import Foundation
import XCTest
@testable import SBTest

class MovieServiceIntegrationTest: XCTestCase {
    var sut: MovieServiceMock?
    
    override func setUp() {
        sut = MovieServiceMock()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testHitAPIrequestMovieList() {
        sut?.requestMovieList { result in
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList)
            default:
                break
            }
        }
    }
    
}
