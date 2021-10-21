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
        
//        fetchContent()
        alamofireFetchMusicAlbum()
    }
}

extension MusicAlbumViewController {
    
    func alamofireFetchMusicAlbum() {
        AF.request(ApiManager.shared.musicURL)
            .validate()
            .responseDecodable (of: MusicAlbum.self) { dataResponse in
                switch dataResponse.result {
                    
                case let .success(musicData):
                    self.artistName.text = musicData.albums.album.first?.artist.name
                    self.albumName.text = musicData.albums.album.first?.name
                    self.activityIndicator.stopAnimating()
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    
//    private func fetchContent() {
//        NetworkManager.shared.fetchMusicAlbum { musicAlbum in
////            let imageString = "\(musicAlbum.albums.album.first?.image.first?.text ?? "No image")"
//            let imageString = "\(musicAlbum.albums.album.first?.image[3].text ?? "Noooo")"
//            print(imageString)
//            guard let imageURL = URL(string: imageString) else { return }
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//            DispatchQueue.main.async {
//                self.albumCoverImage.image = UIImage(data: imageData)
//                self.artistName.text = musicAlbum.albums.album.first?.artist.name
//                self.albumName.text = musicAlbum.albums.album.first?.name
//                self.activityIndicator.stopAnimating()
//            }
//        }
//    }
}
