//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    
    static func getRestaurants(completion: @escaping ([Restaurant]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "MR-sVqqEv2Kp68oK2wmH6zlH4PBECqH29te5lUNM-rCh3XP9X-zocGuAvCw8NLH6adU6UP20cjPl-efbiqOvAxLSs_rWc6D6DLoZ9FpiLkbmpZMnX42hfrCm0OfkXnYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print(data)
        

                // ––––– TODO: Get data from API and return it using completion
                //Convert json response to a dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let restDictionaries = dataDictionary["businesses"] as! [[String: Any]]
                var restaurants : [Restaurant] = []
                for dictionary in restDictionaries{
                    let restaurant = Restaurant.init(dict: dictionary)
                    restaurants.append(restaurant)
                }
                //2. Grab the businesses data and convert it to an array of dictionaries
                return completion(restaurants)
                }
            }
        
            task.resume()
        
        }
    }

    
