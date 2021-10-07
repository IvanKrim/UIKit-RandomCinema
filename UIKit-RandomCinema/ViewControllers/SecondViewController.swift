//
//  SecondViewController.swift
//  UIKit-RandomCinema
//
//  Created by Kalabishka Ivan on 06.10.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var cinemaCover: UIImageView!
    
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var movieLength: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchKino()
    }
}

extension SecondViewController {
    
    func fetchKino() {
        let stringUrl = "https://api.kinopoisk.dev/movie?field=rating.kp&search=7-10&field=rating.imdb&search=7.5-10&field=rating.tmdb&search=7-10&field=year&search=1990-2020&field=typeNumber&search=1&sortField=votes.imdb&sortType=-1&limit=1&page=10&token=Z1KQTWB-7Z8MDMM-KEKM5RB-5Y2P1YE"
        
        guard let url = URL(string: stringUrl) else { return }
        let task = URLSession.shared.dataTask(with: url) {( data, _, error) in
            
            if let error = error {
                print("This id error - \(error.localizedDescription) ")
                return
            }
            
            guard let data = data else { return }
            
            guard let cinema = try? JSONDecoder().decode(Cinema.self, from: data) else { return }
            
            let imageString = "\(cinema.docs.first!.poster.url)"
            
            guard let imageURL = URL(string: imageString) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.yearLabel.text = "\(cinema.docs.first!.year)"
                self.descriptionLabel.text = cinema.docs.first!.description
                self.cinemaCover.image = UIImage(data: imageData)
                self.movieLength.text = "\(cinema.docs.first!.movieLength)"
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
}
