//
//  CardViewCellTableViewCell.swift
//  MovieTMDB
//
//  Created by Manar on 6/6/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import UIKit
import Kingfisher

class
Cell {

    var movie : Movie? {
        didSet{
         //   let processor = DownsamplingImageProcessor(size: imageView.bounds.size)>> RoundCornerImageProcessor(cornerRadius: 20)
            let url = URL(string: Constants.BASE_IMAGE_URL + ((movie?.posterPath) ?? "" ))
            posterView.kf.setImage(with: url)
            titleLabel.text = movie?.title
            rateLabel.text = String(format:"%f", movie?.voteAverage ?? 0) + " / 10"
            releaseLabel.text = movie?.releaseDate
        }
    }
    @IBOutlet private weak var posterView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    
    private let xibName = "CardViewCellTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
