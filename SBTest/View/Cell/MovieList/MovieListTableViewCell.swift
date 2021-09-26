//
//  MovieListTableViewCell.swift
//  SBTest
//
//  Created by Stockbit on 06/08/21.
//

import UIKit
import Kingfisher

final class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: MovieListModel.ViewModel.Movie? {
        didSet {
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        descriptionLabel.numberOfLines = 4
        movieImageView.layer.cornerRadius = 8
        movieImageView.contentMode = .scaleAspectFill
        setupPlayIcon()
    }
    
    private func setupPlayIcon() {
        let playImage = UIImage(named: "Play Small")
        let playImageView = UIImageView(image: playImage)
        movieImageView.addSubview(playImageView)
        playImageView.center = movieImageView.convert(movieImageView.center, from:movieImageView.superview)
    }
    
    private func bindData() {
        titleLabel.text = movie?.title ?? ""
        descriptionLabel.text = movie?.description ?? ""
        releaseLabel.text = movie?.release ?? ""
        setupImage(urlString: movie?.thumbnailPotrait ?? "")
        setupRating(rating: movie?.rating ?? "")
        if !(movie?.rating?.isEmpty ?? true) && movie?.rating != "N/A" {
            ratingLabel.text = movie?.rating
        } else {
            ratingLabel.text = "0"
        }
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
    
    private func setupImage(urlString: String) {
        let memoryCache = ImageCache.default
        if let url = URL(string: urlString) {
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
            memoryCache.memoryStorage.config.totalCostLimit = 30 * 1024 * 500
            memoryCache.memoryStorage.config.countLimit = 50
        }
    }
}
