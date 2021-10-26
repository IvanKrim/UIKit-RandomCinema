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
    
    // MARK: - URLSession
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
    
    // MARK: - Alamofire
    func fetchMusicAlbum(with completion: @escaping (MusicAlbum)->()) {
        AF.request(ApiManager.shared.musicURL)
            .validate()
            .responseDecodable (of: MusicAlbum.self) { dataResponse in
                switch dataResponse.result {
                    
                case .success(let musicData):
                    completion(musicData)
                case .failure(let error):
                    print(error)
                }
                
            }
    }
}
