//
//  Router.swift
//  ListApp
//
//  Created by DavidFresh on 3/12/18.
//  Copyright © 2018 davidfresh. All rights reserved.
//

import Foundation

public final class NetworkClient {
    
    // MARK: - Instance Properties
    internal let baseURL: URL
    internal let session = URLSession.shared
    
    // MARK: - Class Constructors
    public static let shared: NetworkClient = {
        let file = Bundle.main.path(forResource: "ServerEnvironments", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: file)!
        let urlString = dictionary["service_url"] as! String
        let url = URL(string: urlString)!
        return NetworkClient(baseURL: url)
    }()
    
    // MARK: - Object Lifecycle
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    public func getProducts(success _success: @escaping ([ItemApp]) -> Void,
                            failure _failure: @escaping (NetworkError) -> Void) {
        let success: ([ItemApp]) -> Void = { Items in
            DispatchQueue.main.async { _success(Items) }
        }
        let failure: (NetworkError) -> Void = { error in
            DispatchQueue.main.async { _failure(error) }
        }
        let url = baseURL
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data),
                let json = jsonObject as? [String: Any], let data2 =  json["feed"] as? [String: Any], let array = data2["entry"] as? [[String:Any]] else {
                    if let error = error {
                        failure(NetworkError(error: error))
                    } else {
                        failure(NetworkError(response: response))
                    }
                    return
            }
            
                let products = ItemApp.array(jsonArray: array)
                success(products)

        })
        
        task.resume()
    }
    

}

extension Int {
    public var isSuccessHTTPCode: Bool {
        return 200 <= self && self < 300
    }
}
