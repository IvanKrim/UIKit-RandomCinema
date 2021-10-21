//
//  SecondViewController.swift
//  UIKit-RandomCinema
//
//  Created by Kalabishka Ivan on 06.10.2021.
//




import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var movieLength: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchContent()
    }
    
    // MARK: - IB Action
    @IBAction func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func reloadButtonPressed() {
        ApiManager.shared.randomPage()
        fetchContent()
        activityIndicator.startAnimating()
    }
}

extension SecondViewController {
    // MARK: - Private Methods
    private func fetchContent() {
        NetworkManager.shared.fetchMovie { movie in
            self.yearLabel.text = "\(movie.docs.first?.year ?? 0)"
            self.movieLength.text = "\(movie.docs.first?.movieLength ?? 0)"
            self.descriptionLabel.text = movie.docs.first?.description
            guard let imageData = ImageManager.shared.fetchImage(from: movie.docs.first?.poster.url) else { return }
            
            DispatchQueue.main.async {
                self.moviePoster.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}






