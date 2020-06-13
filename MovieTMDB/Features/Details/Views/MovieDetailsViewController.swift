//
//  MovieDetailsViewController.swift
//  MovieTMDB
//
//  Created by Manar on 6/6/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController,DetailsViewControllerProtocol {
    var presenter: DetailsPresenterProtocol?
    
    func displayDetails(withMovie: Movie) {
        titleLabel?.text = movie?.title
        reviewLabel?.text = movie?.overview
        let url = URL(string: (Constants.BASE_IMAGE_URL + ((movie?.posterPath) ?? "")))
        posterView?.kf.setImage(with: url)
        rateAndPopularityLabel.text = "Popularity: \(String(describing: (movie?.popularity)!)) \nRate: \((movie?.voteAverage)!) / 10\nVotes Number: \(String(describing: (movie?.voteCount)!))"
    }
    
    var movie:Movie?
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var rateAndPopularityLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var posterView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailsPresenter(controller: self)
        if let movie = movie {
            presenter?.showDetails(withMovie: movie)
        }
    }

}
