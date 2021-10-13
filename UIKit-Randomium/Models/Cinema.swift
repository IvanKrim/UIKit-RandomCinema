//
//  Cinema.swift
//  UIKit-RandomCinema
//
//  Created by Kalabishka Ivan on 07.10.2021.
//

import Foundation

struct Cinema: Codable {
    let docs: [Doc]
}

struct Doc: Codable {
    let poster: Poster
    let name: String
    let description: String
    let year: Int
    let movieLength: Int
}

struct Poster: Codable {
    let url: String
}

