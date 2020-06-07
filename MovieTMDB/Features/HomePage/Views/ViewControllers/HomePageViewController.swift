//
//  HomePageViewController.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import UIKit

extension HomePageViewController{
     enum TableViewSections {
        case mainSection
    }
}

extension HomePageViewController: HomePageControllerProtocol {
    func updateUIDataSource(currentPage:Int, pageMovies: [Movie]) {
        self.currentPage = currentPage
        self.moviesToDisplay = self.moviesToDisplay + pageMovies
        createSnapShot(withData: moviesToDisplay)
      //  self.movieTableView.reloadData()
    }
    
    
    func updateTotalPages(totalPages: Int) {
       self.totalOfPages = totalPages
    }
    func displayMessage(title: String, message:String) {
        self.showSimpleAlert(title: title, message: message)
    }
}
class HomePageViewController: UIViewController,UITableViewDelegate {
    
    /// For table view in this controller, Diffable data sources for table view is used, instead of ui table view datasource delegate
    private var dataSource: UITableViewDiffableDataSource<TableViewSections, Movie>! = nil
    var moviesToDisplay: [Movie] = []
    private var currentPage: Int = 1
    private var totalOfPages: Int?
    private let CELL_SIZE:CGFloat = 250
    private let HEADER_TITLE = "TMDB Movies"
    private let reuseIdentifier = "movieCell"
    private let CELL_NAME = "CardViewCell"
    
    lazy var homePresenter: HomePagePresenterProtocol = HomePagePresenter()
    @IBOutlet private weak var searchBar: CustomSearchBar!
    @IBOutlet private weak var movieTableView: UITableView!
    private let spinner = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        setUp()
        setReloadSpinner()
        NetworkReachability.shared.startNetworkReachabilityObserver()
    }
    
    private func setUp(){
        self.navigationItem.title = HEADER_TITLE
        self.searchBar.delegate = self
        self.homePresenter.homeController = self
        homePresenter.getMovies(forPage: currentPage)
    }
    private func initTableView(){
        // set table view delegates and datasource
        movieTableView.delegate = self
        configureTableViewDiffableDataSource()
        let nib = UINib.init(nibName: CELL_NAME, bundle: nil)
        movieTableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func setReloadSpinner(){
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: self.movieTableView.frame.width, height: 44)
        self.movieTableView.tableFooterView = spinner;
    }
    
    private func stopReloadSpinner(){
        spinner.stopAnimating()
        self.movieTableView.tableFooterView = nil
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if (indexPath.row == (self.moviesToDisplay.count) - 1) {
            if currentPage <= (totalOfPages ?? 1) {
                homePresenter.getMovies(forPage: currentPage + 1) // network request to get more data
            }
         }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_SIZE
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesToDisplay.count
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "movieDetailsViewController") as! MovieDetailsViewController
        guard let movie = dataSource.itemIdentifier(for: indexPath) else {return}
        movieDetailsViewController.movie = movie
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
        
    }
    
    private func configureTableViewDiffableDataSource() {
        dataSource = UITableViewDiffableDataSource<TableViewSections, Movie>(tableView: movieTableView) {
            (tableView: UITableView, indexPath: IndexPath, identifier: Movie) -> UITableViewCell? in
            let movieCell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! CardViewCell
            if let movie = self.dataSource.itemIdentifier(for: indexPath){
                movieCell.movie = movie
            }
            return movieCell
        }
    }
    
    private func createSnapShot(withData movies: [Movie]){
        var snapshot = NSDiffableDataSourceSnapshot<TableViewSections, Movie>()
        snapshot.appendSections([.mainSection])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

extension HomePageViewController: UISearchBarDelegate{
    
    func performSearch(searchQuery: String?) {
        var filteredMovies = moviesToDisplay
        if let searchQuery = searchQuery, !searchQuery.isEmpty {
            filteredMovies = moviesToDisplay.filter { $0.title.lowercased().hasPrefix(searchQuery.lowercased()) }
            stopReloadSpinner()
        }
        if(filteredMovies == moviesToDisplay){
            setReloadSpinner()
        }
        createSnapShot(withData: filteredMovies)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch(searchQuery: searchText)
    }
}
