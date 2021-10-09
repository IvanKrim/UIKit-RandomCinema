//
//  ApiManager.swift
//  UIKit-RandomCinema
//
//  Created by Kalabishka Ivan on 08.10.2021.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    private init() {}
    
    var pageNumber = Int.random(in: 0..<300)
    
    var stringUrl: String { "https://api.kinopoisk.dev/movie?field=rating.kp&search=7-10&field=rating.imdb&search=7.5-10&field=rating.tmdb&search=7-10&field=year&search=1990-2020&field=typeNumber&search=1&sortField=votes.imdb&sortType=-1&limit=1&page=\(pageNumber)&token=Z1KQTWB-7Z8MDMM-KEKM5RB-5Y2P1YE" }
    
    func randomPage() {
        pageNumber = Int.random(in: 0..<300)
    }
    
}

