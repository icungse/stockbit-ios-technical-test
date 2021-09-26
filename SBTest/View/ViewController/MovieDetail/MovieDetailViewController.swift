import UIKit

protocol IMovieDetailViewController: AnyObject {
    func displayMovieDetail(viewModel: MovieDetailModel.ViewModel)
}

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    private var interactor: IMovieDetailInteractor!
    
    convenience init(movie: Movie) {
        let bundle = Bundle(for: type(of: self))
        self.init(nibName: "MovieDetailViewController", bundle: bundle)
        setup(movie: movie)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setup(movie: Movie) {
        let presenter = MovieDetailPresenter(view: self)
        interactor = MovieDetailInteractor(presenter: presenter, movie: movie)
    }

}

extension MovieDetailViewController: IMovieDetailViewController {
    func displayMovieDetail(viewModel: MovieDetailModel.ViewModel) {
        #warning("Fix this function")
    }
}
