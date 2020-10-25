//
//  ViewController.swift
//  SearchMov
//
//  Created by Mathew Thomas on 25/10/2020.
//

import UIKit

class SearchController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    private var data: [SearchElement] = []
    private let networkManager = NetworkManager()
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.searchBar.delegate = self
        
        // NavBar & SearchBar
        searchBar.placeholder = "Search Movies"
        navigationItem.titleView = searchBar
        title = "Search"
        
        // Register tableView cells
        self.registerTableViewCells()
        
        // Get data from API (Placeholder data)
        if ConnectionManager.isConnectedToNetwork() {
            if let results = networkManager.searchMovieByName(name: "Star wars") {
                for item in results {
                    data.append(item)
                }
            }
        }else{
            self.showAlert()
        }
    }
    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? SearchResultCell {
            
            let movie = data[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.titleLabel.adjustsFontSizeToFitWidth = true
            cell.titleLabel.minimumScaleFactor = 0.2
            cell.titleLabel.text = movie.Title
            cell.yearLabel.text = movie.Year
            cell.movieImageView.downloadImage(from: URL(string: movie.Poster!)!, imageView: cell.movieImageView)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = data[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        resultViewController.imdbID = movie.imdbID!
        resultViewController.title = "Movie Details"
        resultViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(resultViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func registerTableViewCells() {
        let searchCell = UINib(nibName: "SearchResultCell", bundle: nil)
        self.tableview.register(searchCell, forCellReuseIdentifier: "SearchResultCell")
    }
    
    // MARK: - SearchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        if !searchBar.text!.isEmpty {
            data.removeAll()
            
            if ConnectionManager.isConnectedToNetwork() {
                if let results = networkManager.searchMovieByName(name: searchBar.text!) {
                    for item in results {
                        data.append(item)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
            }else {
                showAlert()
            }
        }
    }
}
