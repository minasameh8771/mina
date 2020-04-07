//
//  MyMovie.swift
//  RegisterApp
//
//  Created by mina sameh on 3/29/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit
import Foundation

struct MyMovie: Decodable {
    var title: String
    var image: String
    var rating: Double
    var releaseYear: Int
    var genre : [String]
    
  /*  enum CodingKeys: String, CodingKey {
        case title
        case imagee = "image"
        case rating
        case releaseYear
    }*/
}


