//
//  MusicAlbumViewController.swift
//  UIKit-RandomCinema
//
//  Created by Kalabishka Ivan on 16.10.2021.
//

import UIKit
import Alamofire

class MusicAlbumViewController: UIViewController {
    
    @IBOutlet var albumCoverImage: UIImageView!
    
    @IBOutlet var artistName: UILabel!
    @IBOutlet var albumName: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchContent()
    }
}

extension MusicAlbumViewController {
    
    private func fetchContent() {
        NetworkManager.shared.fetchMusicAlbum { musicAlbum in
            self.artistName.text = musicAlbum.albums.album.first?.artist.name
            self.albumName.text = musicAlbum.albums.album.first?.name
            self.activityIndicator.stopAnimating()
            print(musicAlbum.albums.album.first?.image.first?.text ?? "no image data")
            
            guard let imageData = ImageManager.shared.fetchImage(from: musicAlbum.albums.album.first?.image[3].text) else { return }
            
            DispatchQueue.main.async {
                self.albumCoverImage.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
