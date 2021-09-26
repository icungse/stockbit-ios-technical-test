import Foundation

protocol IMovieListInteractor {
    func fetchMovieList()
    func getMoviesCount() -> Int
    func getMoviesViewModel() -> [MovieListModel.ViewModel.Movie]
    func getMoviesEntity() -> [Movie]
    func getNextPage()
}

class MovieListInteractor: IMovieListInteractor {
    
    // MARK: Private
    private let service: IMovieService
    private let presenter: IMoviesPresenter
    
    // MARK: Lifecycle
    
    init(presenter: IMoviesPresenter, service: IMovieService) {
        self.presenter = presenter
        self.service = service
    }

    // MARK: Internal

    func fetchMovieList() {
        #warning("Handle API Response")
    }
    
    func getMoviesEntity() -> [Movie] {
        #warning("Fix Me")
        return []
    }

    func getMoviesCount() -> Int {
        #warning("Fix Me")
        return 0
    }

    func getMoviesViewModel() -> [MovieListModel.ViewModel.Movie] {
        #warning("Fix Me")
        return []
    }

    func getNextPage() {
        #warning("Load More")
    }
}
