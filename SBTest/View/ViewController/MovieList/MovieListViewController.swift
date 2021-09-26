import UIKit

protocol IMoviesViewController: AnyObject {
    func displaySuccesGetMoviesList()
}

class MovieListViewController: UIViewController {

    // MARK: Private
    private var interactor: IMovieListInteractor?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchMovie()
    }

    private func setup() {
        let presenter = MoviesListPresenter(view: self)
        interactor = MovieListInteractor(presenter: presenter, service: MovieService())
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchMovie() {
        #warning("Fetch from API")
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #warning("Setup table view cell")
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #warning("Handle didselect")
    }
}

// MARK: - IMoviesPresenter

extension MovieListViewController: IMoviesViewController {
    func displaySuccesGetMoviesList() {
        #warning("Handle to display view")
    }
}
