//
//  Media.swift
//  RegisterApp
//
//  Created by mina sameh on 3/31/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit
import Foundation



struct Media : Decodable{
    var trackName : String?
    var artistName : String?
    var artworkUrl100 : String
    var longDescription : String?
    var previewUrl : String
    var kind : String
    
    init(trackName : String , artistName : String ,artworkUrl100 : String , longDescription : String , previewUrl : String , kind : String ) {
        
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.longDescription = longDescription
        self.previewUrl = previewUrl
        self.kind = kind
    }

    
    func getType() -> MediaType {
        switch self.kind {
        case "song":
            return MediaType.music
        case "feature-movie" :
            return MediaType.movie
        case "tv-episode" :
            return MediaType.tvShow
        default:
            return MediaType.music
        }
    }
    
    
}
