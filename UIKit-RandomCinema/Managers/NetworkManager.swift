//
//  NetworkManager.swift
//  UIKit-RandomCinema
//
//  Created by Kalabishka Ivan on 08.10.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchCinema(completion: @escaping (Cinema) -> ()) {
        
        guard let url = URL(string: ApiManager.shared.stringUrl) else { return }
        URLSession.shared.dataTask(with: url) { ( data, _, error) in
            
            if let error = error {
                print("This id error - \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            
            do {
                let cinema = try JSONDecoder().decode(Cinema.self, from: data)
                completion(cinema)
            } catch let jsonError {
                print("Ошибка получения данных", jsonError)
            }
        }.resume()
    }
}
