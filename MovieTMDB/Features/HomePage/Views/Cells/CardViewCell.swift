//
//  CardViewCellTableViewCell.swift
//  MovieTMDB
//
//  Created by Manar on 6/6/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import UIKit
import Kingfisher

class CardViewCell: UITableViewCell {
    @IBOutlet private weak var posterView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    
    var movie : Movie? {
        didSet{
            let url = URL(string: (Constants.BASE_IMAGE_URL + ((movie?.posterPath) ?? "")))
            posterView.kf.setImage(with: url)
            titleLabel?.text = movie?.title
            rateLabel?.text = String(format:"%.1f", movie?.voteAverage ?? 0) + " / 10"
            releaseLabel?.text = "release date: " + (movie?.releaseDate ?? "")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
