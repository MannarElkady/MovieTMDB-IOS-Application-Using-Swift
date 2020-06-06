//
//  CardViewCellTableViewCell.swift
//  MovieTMDB
//
//  Created by Manar on 6/6/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import UIKit

class CardViewCellTableViewCell: UITableViewCell {

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
