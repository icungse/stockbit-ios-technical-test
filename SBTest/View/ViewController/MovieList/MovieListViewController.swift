import UIKit

protocol IMoviesViewController: AnyObject {
    func displaySuccesGetMoviesList(movieList: MovieList)
}

class MovieListViewController: UIViewController {

    // MARK: Private
    private var interactor: IMovieListInteractor?
    private var movieList: [MovieListModel.ViewModel.Movie] = []
    private var isLoading = false
    private lazy var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchMovie()
        setupNavigation()
    }

    private func setup() {
        let presenter = MoviesListPresenter(view: self)
        interactor = MovieListInteractor(presenter: presenter, service: MovieService())
        
        let nib = UINib.init(nibName: "MovieListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
    }
    
    private func setupNavigation() {
        let titleLabel = UILabel()
        titleLabel.text = "Movies"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        navigationItem.titleView = titleLabel
        if let navigationBar = navigationController?.navigationBar {
            titleLabel.widthAnchor.constraint(equalTo: navigationBar.widthAnchor, constant: -40).isActive = true
        }
    }
    
    private func fetchMovie() {
        interactor?.fetchMovieList()
        isLoading = true
    }
    
    @objc private func pullRefresh() {
        if !isLoading {
            fetchMovie()
        }
    }
    
    private func loadMoreData(){
        if !isLoading {
            interactor?.getNextPage()
        }
        isLoading = true
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        cell.movie = movieList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movies = interactor?.getMoviesEntity()
        let movie = movies?[indexPath.row]
        let controller = MovieDetailViewController()
        controller.movie = movie
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == movieList.count {
            if !isLoading {
                loadMoreData()
            }
        }
    }
}

// MARK: - IMoviesPresenter

extension MovieListViewController: IMoviesViewController {
    func displaySuccesGetMoviesList(movieList: MovieList) {
        DispatchQueue.main.async {
            if let movieListViewModel = self.interactor?.getMoviesViewModel() {
                self.isLoading = false
                self.movieList.removeAll()
                self.movieList = movieListViewModel
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}
