//
//  HomePageContracts.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation

protocol HomePagePresenterProtocol {
    var homeController: HomePageControllerProtocol? {set get}
    func getOnlineMovies(forPage page:Int)
    func getOfflineMovies() -> [Movie]
}

protocol HomePageControllerProtocol {
    var homePresenter: HomePagePresenterProtocol {set get}
    func updateUIDataSource(pageMovies:[Movie])
    func displayNoMoreData()
    func displayError(title:String,message:String)
}
