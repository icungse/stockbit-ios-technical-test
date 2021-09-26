import UIKit
import Kingfisher

protocol IMovieDetailViewController: AnyObject {
    func displayMovieDetail(viewModel: MovieDetailModel.ViewModel)
}

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    private var interactor: IMovieDetailInteractor!
    
    var movie: Movie?
    
    convenience init(movie: Movie) {
        let bundle = Bundle(for: type(of: self))
        self.init(nibName: "MovieDetailViewController", bundle: bundle)
        setup(movie: movie)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            setup(movie: movie)
        }
        setupView()
    }
    
    private func setup(movie: Movie) {
        let presenter = MovieDetailPresenter(view: self)
        interactor = MovieDetailInteractor(presenter: presenter, movie: movie)
        interactor.handleMovieDetail()
    }
    
    private func setupView() {
        movieImageView.contentMode = .scaleAspectFill
        setupBackButton()
    }

    private func setupImage(urlString: String) {
        if let url = URL(string: urlString) {
            let memoryCache = ImageCache.default
            let resource = ImageResource(downloadURL: url, cacheKey: urlString)
            
            let processor = DownsamplingImageProcessor(size: movieImageView.bounds.size)
                |> RoundCornerImageProcessor(cornerRadius: 0)
        
            movieImageView.kf.indicatorType = .activity
            movieImageView.kf.setImage(
                with: resource,
                options: [
                    .processor(processor),
                    .transition(.fade(1)),
                    .cacheOriginalImage,
                    .targetCache(memoryCache),
                    .memoryCacheExpiration(.seconds(30))
                    
                ])
            memoryCache.memoryStorage.config.totalCostLimit = 30 * 1024 * 1024
            memoryCache.memoryStorage.config.countLimit = 50
        }
    }
    
    private func setupBackButton() {
        let closeImage = UIImage(named: "close")
        let closeButton = UIButton(type: .system)
        closeButton.tintColor = .black
        closeButton.setImage(closeImage, for: .normal)
        closeButton.frame = CGRect(x: 20, y: 30, width: 30, height: 30)
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    private func setupRating(rating: String) {
        let ratingInt: Int = (rating as NSString).integerValue / 2
        let stars = [star1,star2,star3,star4,star5]
        for i in stars.indices{
            stars[i]?.image = UIImage(named: "Star Empty")
        }
        
        for i in 0..<ratingInt{
            stars[i]?.image = UIImage(named: "Star Fill")
        }
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
}

extension MovieDetailViewController: IMovieDetailViewController {
    func displayMovieDetail(viewModel: MovieDetailModel.ViewModel) {
        titleLabel.text = viewModel.title
        countryLabel.text = viewModel.country
        genreLabel.text = viewModel.genre
        descriptionLabel.text = viewModel.description
        if !viewModel.rating.isEmpty && movie?.rating != "N/A" {
            ratingLabel.text = movie?.rating
        } else {
            ratingLabel.text = "0"
        }
        setupImage(urlString: viewModel.thumbnailLandscape)
        setupRating(rating: viewModel.rating)
    }
}
