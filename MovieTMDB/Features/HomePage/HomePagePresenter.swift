//
//  HomePagePresenter.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation

class HomePagePresenter:HomePagePresenterProtocol  {
    var homeController: HomePageControllerProtocol?
    lazy var networkLayer = NetworkService(httpHandler: HttpHandler())
    func getOnlineMovies(forPage page: Int) {
        if NetworkService.isNetworkAvailable {
            let errorHandler : (Error) -> Void = { [weak self]
                error in
                print(error)
                self?.homeController?.displayError(title: "Can't load data", message: error.localizedDescription)
            }
            networkLayer.getLatestMovies(withPage: page, completionHandler: { [weak self]
                pageMovies in
                self?.homeController?.updateUIDataSource(pageMovies: pageMovies.movies)
            }, errorHandler: errorHandler)
        }
        else{
            self.homeController?.displayError(title: "No Internet Connection", message: "please connect your Internet to load more..")
        }
    }
    
    func getOfflineMovies() -> [Movie] {
        return [Movie]()
    }
}
