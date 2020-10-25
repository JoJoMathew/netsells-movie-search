//
//  DetailController.swift
//  SearchMov
//
//  Created by Mathew Thomas on 25/10/2020.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    private let networkManager = NetworkManager()
    var imdbID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        
        let labels = [titleLabel, yearLabel, releaseLabel, genreLabel, runtimeLabel, directorLabel, actorsLabel, plotLabel]
        
        if ConnectionManager.isConnectedToNetwork() {
            if let movie = networkManager.getMovieDetailsByID(id: imdbID) {
                
                movieImage.downloadImage(from: URL(string: movie.Poster!.replacingOccurrences(of: "SX300", with: "SX500"))!, imageView: movieImage)
                titleLabel.text = movie.Title
                yearLabel.text = movie.Year
                releaseLabel.text = movie.Released
                genreLabel.text = movie.Genre
                runtimeLabel.text = movie.Runtime
                directorLabel.text = movie.Director
                actorsLabel.text = movie.Actors
                plotLabel.text = movie.Plot
                
                for label in labels {
                    label?.sizeToFit()
                }
            }
            
        }else {
            self.showAlert()
        }
    }
}
