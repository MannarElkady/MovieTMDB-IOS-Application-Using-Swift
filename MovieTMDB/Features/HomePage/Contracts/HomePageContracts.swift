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
    
    func getMovies(forPage page:Int)
    func getSavedMovies() -> [Movie]
    func saveMovies(lastPageMovies: [Movie])
    func deleteAllMovies()
}

protocol HomePageControllerProtocol {
    var homePresenter: HomePagePresenterProtocol {get}
    func updateTotalPages(totalPages:Int)
    func updateUIDataSource(currentPage:Int,pageMovies:[Movie])
    func displayMessage(title:String,message:String)

}
