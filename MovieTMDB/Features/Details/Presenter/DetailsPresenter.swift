//
//  DetailsPresenter.swift
//  MovieTMDB
//
//  Created by Manar on 6/13/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation

struct DetailsPresenter: DetailsPresenterProtocol {
    var controller: DetailsViewControllerProtocol?
    init(controller:DetailsViewControllerProtocol) {
        self.controller = controller
    }
    func showDetails(withMovie movie: Movie) {
        self.controller?.displayDetails(withMovie: movie)
    }
}
