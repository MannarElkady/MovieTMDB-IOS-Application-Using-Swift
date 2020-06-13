//
//  DetailsContracts.swift
//  MovieTMDB
//
//  Created by Manar on 6/13/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation


protocol DetailsViewControllerProtocol {
    var presenter: DetailsPresenterProtocol? {get}
    func displayDetails(withMovie: Movie)
}

protocol DetailsPresenterProtocol {
    var controller: DetailsViewControllerProtocol? {get}
    func showDetails(withMovie movie: Movie)
}
