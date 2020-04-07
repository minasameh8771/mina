//
//  SqliteManager.swift
//  RegisterApp
//
//  Created by mina sameh on 4/2/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import Foundation
import SQLite

class SqliteManager {
    
    static var dataBase : Connection!
    
    static let MediaTB = Table("Media")
    
    static let trackName = Expression<String>("trackName")
    static let artistName = Expression<String>("artistName")
    static let artworkUrl100 = Expression<String>("artworkUrl100")
    static let longDescription = Expression<String>("longDescription")
    static let previewUrl = Expression<String>("previewUrl")
    static let kind = Expression<String>("kind")
    
    
    static func CreateConnection(){
        do {
            let docementDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = docementDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.dataBase = database
        } catch {
            print(error)
        }
    }
    
    fileprivate static func CreateTable (){
        
        do {
            guard let dataBase = self.dataBase else {return}
            
            try dataBase.run(MediaTB.create { t in
                t.column(trackName)
                t.column(artistName)
                t.column(artworkUrl100)
                t.column(longDescription)
                t.column(previewUrl)
                t.column(kind)
                print("table Create")
            })
        } catch {
            print(error)
        }

    }
    
    static func InsertToDB (media : [Media]) {
        for item in media {
            
            let insert = MediaTB.insert(
                trackName <- item.trackName ?? "" ,
                artistName <- item.artistName ?? "" ,
                artworkUrl100 <- item.artworkUrl100 ,
                longDescription <- item.longDescription ?? "" ,
                previewUrl <- item.previewUrl ,
                kind <- item.kind
            )
            
            do {
                try dataBase.run(insert)
            } catch {
                print(error)
            }
        }
        
    }
    
    static func LoadDB () -> [Media] {
        var mediaArr = [Media]()
        
        do {
            for item in try dataBase.prepare(MediaTB) {
                
                let mediaItem = Media(trackName: item[self.trackName], artistName: item[self.artistName], artworkUrl100: item[self.artworkUrl100], longDescription: item[self.longDescription], previewUrl: item[self.previewUrl], kind: item[self.kind])
                
                mediaArr.append(mediaItem)
            }
        } catch {
            print(error)
        }
        
        return mediaArr
    }
    
    static func ClearDB (){
        do {
            try dataBase.run(MediaTB.delete())
        } catch {
            print(error)
        }
    }
}
