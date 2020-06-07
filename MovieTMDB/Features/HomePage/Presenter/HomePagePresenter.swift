//
//  HomePagePresenter.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation

class HomePagePresenter: HomePagePresenterProtocol {
    var homeController: HomePageControllerProtocol?
    lazy var networkLayer = NetworkService(httpHandler: HttpHandler())
    private var lastPageMovies:[Movie]?
    func getMovies(forPage page: Int) {
        if NetworkService.isNetworkAvailable {
            let errorHandler : (Error) -> () = { [weak self]
                error in
                print(error)
                self?.homeController?.displayMessage(title: "Can't load data", message: error.localizedDescription)
            }
            
            let completionHandler :(LatestMoviesResponse) -> () = { [weak self]
                pageMovies in
                self?.homeController?.updateTotalPages(totalPages: pageMovies.totalPages)
                self?.lastPageMovies = pageMovies.movies
                self?.homeController?.updateUIDataSource(currentPage: pageMovies.page, pageMovies: pageMovies.movies)
                if(page == pageMovies.totalPages){
                    self?.homeController?.displayMessage(title: "No More Movies" , message: "You've loaded all the movies available")
                }
            }
            networkLayer.getLatestMovies(withPage: page, completionHandler: completionHandler, errorHandler: errorHandler)
        }
            
        else{
            //check if load from network before - since application runs (not first time only) - or not
            if(page == 1){
                // user didn't load data from network since app opened
                let movies = getSavedMovies()
                self.homeController?.updateUIDataSource(currentPage: 1, pageMovies: movies)
            }
            else{
                // some pages may be previously loaded so save last page as it's went from online to offline
                if let movies = lastPageMovies {
                    saveMovies(lastPageMovies: movies)
                }
            }
            self.homeController?.displayMessage(title: "No Internet Connection", message: "please connect your Internet to load more..")
        }
    }
    
    
    func saveMovies(lastPageMovies: [Movie]){
        //assume to save last scrolled page only when go offline
        DatabaseService.sharedInstance.addMovieList(movies: lastPageMovies)
    }
    
    func getSavedMovies() -> [Movie] {
        return DatabaseService.sharedInstance.getAllMovies()
    }
    
    func deleteAllMovies() {
        DatabaseService.sharedInstance.deleteAll()
    }
}
