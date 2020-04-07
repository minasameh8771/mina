//
//  ApiManager.swift
//  RegisterApp
//
//  Created by mina sameh on 3/29/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class ApiManager: NSObject {
    
    class func loadMyMovies(completion: @escaping (_ error: Error?, _ movies: [MyMovie]?) -> Void) {
        AF.request("https://api.androidhive.info/json/movies.json", method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { response in
            guard response.error == nil else {
                print(response.error!)
                print("response Faild")
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let moviesArr = try decoder.decode([MyMovie].self, from: data)
                completion(nil, moviesArr)
            } catch let error {
                print("faild to decode")
                print(error)
            }
        }
    }
    
    class func loadMedia(_ URL : String , _ param : [String:String] ,completion: @escaping (_ error: Error?, _ movies: [Media]?) -> Void) {
        AF.request(URL, method: HTTPMethod.get, parameters: param, encoding: URLEncoding.default, headers: nil).response { response in
            guard response.error == nil else {
                print(response.error!)
                print("response Faild")
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseBodey = try decoder.decode(ResponseBody.self, from: data)
                let mediaArr = responseBodey.results
                completion(nil, mediaArr)
                
            } catch let error {
                print("faild to decode")
                print(error)
            }
        }
    }
    
    
}

