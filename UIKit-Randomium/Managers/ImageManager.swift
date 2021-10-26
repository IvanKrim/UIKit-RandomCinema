//
//  ImageManager.swift
//  UIKit-RandomCinema
//
//  Created by Kalabishka Ivan on 26.10.2021.
//

import Foundation
import Alamofire

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    // MARK: - URLSession
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
    
    // MARK: - Alamofire
    
    
//    func fetchMusicImage(from url: String, completion: @escaping (Data) -> ()) {
//        AF.request(url)
//            .validate()
//            .responseData { response in
//                switch response.result {
//                case .success(let imageData):
//                    completion(imageData)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
    
}
