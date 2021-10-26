//
//  MovieViewController.swift
//  UIKit-RandomCinema
//
//  Created by Kalabishka Ivan on 06.10.2021.
//

// MARK: - IB Outlets
// MARK: - Public Properties
// MARK: - Private Properties
// MARK: - Initializers
// MARK: - Override Methods
// MARK: - IB Action
// MARK: - Public Methods
// MARK: - Private Methods


import UIKit

class MovieViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var movieLength: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let pageLimit = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchContent()
        ApiManager.shared.randomPage(upTo: pageLimit)
    }
    
    // MARK: - IB Action
    @IBAction func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func reloadButtonPressed() {
        ApiManager.shared.randomPage(upTo: pageLimit)
        fetchContent()
        activityIndicator.startAnimating()
    }
}

extension MovieViewController {
    // MARK: - Private Methods
    private func fetchContent() {
        NetworkManager.shared.fetchMovie { movie in
            self.yearLabel.text = "\(movie.docs.first?.year ?? 0)"
            self.movieLength.text = "\(movie.docs.first?.movieLength ?? 0)"
            self.descriptionLabel.text = movie.docs.first?.description
            
            guard let imageData = ImageManager.shared.fetchImage(from: movie.docs.first?.poster?.url) else { return }
            
            DispatchQueue.main.async {
                self.moviePoster.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}






