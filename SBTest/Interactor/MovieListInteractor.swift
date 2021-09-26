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
    private var movieList: MovieList?
    
    // MARK: Lifecycle
    
    init(presenter: IMoviesPresenter, service: IMovieService) {
        self.presenter = presenter
        self.service = service
    }

    // MARK: Internal

    func fetchMovieList() {
        service.requestMovieList { [weak self] result in
            switch result {
            case .success(let movieList):
                self?.movieList = movieList
                self?.presenter.presentSuccessGetMovieList(movieList: movieList)
            default:
                break
            }
        }
    }
    
    func getMoviesEntity() -> [Movie] {
        var movies = [Movie]()
        if let movieList = movieList?.result {
            for obj in movieList.indices {
                movies.append(
                    Movie(
                        title: movieList[obj].title,
                        thumbnailPotrait: movieList[obj].thumbnailPotrait,
                        rating: movieList[obj].rating,
                        detail:
                            Detail(
                                release: movieList[obj].detail.release,
                                description: movieList[obj].detail.description,
                                country: movieList[obj].detail.country,
                                thumbnailLandscape: movieList[obj].detail.thumbnailLandscape,
                                genre: movieList[obj].detail.genre
                            )
                    )
                )
            }
        }
        return movies
    }

    func getMoviesCount() -> Int {
        #warning("Fix Me")
        return 0
    }

    func getMoviesViewModel() -> [MovieListModel.ViewModel.Movie] {
        var movies: [MovieListModel.ViewModel.Movie] = []
        if let moviesResult = movieList?.result {
            for obj in moviesResult {
                movies.append(
                    MovieListModel.ViewModel.Movie(
                        title: obj.title,
                        thumbnailPotrait: obj.thumbnailPotrait,
                        rating: obj.rating,
                        release: obj.detail.release,
                        description: obj.detail.description
                    )
                )
            }
        }
        
        return movies
    }

    func getNextPage() {
        let nextPage = ((movieList?.page ?? "1") as NSString).intValue + 1
        
        service.loadMoreMovies(page: Int(nextPage)) { Result in
            switch Result {
            case .success(let result) :
                self.movieList?.page = result.page
                self.movieList?.result += result.result
                self.presenter.presentSuccessGetMovieList(movieList: result)
            default:
                break
            }
        }
    }
}
