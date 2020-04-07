//
//  File.swift
//  RegisterApp
//
//  Created by mina sameh on 3/31/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import Foundation
import UIKit


enum MediaType : String {
    case music = "musicTrack"
    case movie = "movie"
    case tvShow = "tvShow"
}

struct ResponseBody : Decodable {
    var resultCount : Int
    var results : [Media]
}
