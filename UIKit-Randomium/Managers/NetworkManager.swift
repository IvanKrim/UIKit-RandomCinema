//
//  NetworkManager.swift
//  UIKit-RandomCinema
//
//  Created by Kalabishka Ivan on 08.10.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - Fetch Movie
    func fetchMovie(with completion: @escaping (Movie) -> ()) {
        guard let url = URL(string: ApiManager.shared.movieURL) else { return }
        
        URLSession.shared.dataTask(with: url) { ( data, _, error) in
            if let error = error {
                print("This error - \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    completion(movie)
                }
            } catch let jsonError {
                print("Ошибка получения данных", jsonError)
            }
        }.resume()
    }
}


class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
}

// MARK: - Alamofire
//    func fetchMusicAlbum(completion: @escaping (MusicAlbum) -> ()) {
//
//        guard let url = URL(string: ApiManager.shared.musicURL) else { return }
//        URLSession.shared.dataTask(with: url) { ( data, _, error) in
//
//            if let error = error {
//                print("This id error - \(error.localizedDescription)")
//                return
//            }
//            guard let data = data else { return }
//
//            do {
//                let musicAlbum = try JSONDecoder().decode(MusicAlbum.self, from: data)
//                completion(musicAlbum)
//            } catch let jsonError {
//                print("Ошибка получения данных", jsonError)
//            }
//        }.resume()
//    }
//
//    func alamofireFetchMusicAlbum() {
//        AF.request(ApiManager.shared.musicURL)
//            .validate()
//            .responseDecodable (of: MusicAlbum.self) { dataResponse in
//                print(dataResponse)
//            }
//
//    }
