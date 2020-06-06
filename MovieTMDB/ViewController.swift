//
//  ViewController.swift
//  MovieTMDB
//
//  Created by Manar on 6/4/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,HomePageControllerProtocol {
    func displayError(title: String, message: String) {
        self.showSimpleAlert(title: title, message: message)
    }
    
    
    lazy var homePresenter:HomePagePresenterProtocol = HomePagePresenter()
    func updateUIDataSource(pageMovies: [Movie]) {
        print(pageMovies)
    }
   
    func displayNoMoreData() {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homePresenter.homeController = self
        homePresenter.getOnlineMovies(forPage: 3)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
