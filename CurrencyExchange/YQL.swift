//
//  YQL.swift
//  CurrencyExchange
//
//  Created by CampusUser on 5/9/17.
//  Copyright © 2017 Juan Aguillon. All rights reserved.
//  Code provided by instructor David McLaren
//


import Foundation

class YQL {
    private let QUERY_PREFIX = "https://query.yahooapis.com/v1/public/yql?q="
    private let QUERY_SUFFIX = "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
    
    public func query(_ statement:String, completion: @escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(QUERY_PREFIX)\(statement.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)\(QUERY_SUFFIX)")
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let dataDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    let results:[String: Any] = dataDict!
                    completion(results)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}

