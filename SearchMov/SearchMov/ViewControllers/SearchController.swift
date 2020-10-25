//
//  ViewController.swift
//  SearchMov
//
//  Created by Mathew Thomas on 25/10/2020.
//

import UIKit

class SearchController: UIViewController {
    
    private let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        // test network
        if ConnectionManager.isConnectedToNetwork() {
            if let results = networkManager.searchMovieByName(name: "Star wars") {
                for item in results {
                    print(item.Title)
                }
            }
        }
        
    }

}
