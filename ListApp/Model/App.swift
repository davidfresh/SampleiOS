//
//  App.swift
//  ListApp
//
//  Created by DavidFresh on 3/12/18.
//  Copyright © 2018 davidfresh. All rights reserved.
//

import Foundation


public final class ItemApp {

    internal struct Keys {

        static let nameApp = "label"
        static let imageApp = "label"
        static let priceApp = "amount"
        static let appDescription = "label"
    }
    
    internal static var tableName = "products"
    
    // MARK: - Instance Properties
    
    public let imageURL: URL?
    public let priceApp: String
    public let appDescription: String
    public let title: String
    
    
    // MARK: - Object Lifecycle
    public init?(json: [String: Any]) {
        
         guard let name = json["im:name"] as? [String: Any] else {return nil}
         guard let descriptionApp = json["summary"] as? [String: Any] else {return nil}
         guard let pricesArray = json["im:price"] as? [String: Any] else {return nil}
         guard let prices = pricesArray["attributes"] as? [String: Any] else {return nil}
         guard let image = json["im:image"] as? [[String: Any]] else {return nil}
        
        let imageURL: URL?
        
        if let imageURLString = image.first![Keys.imageApp] as? String {
            imageURL = URL(string: imageURLString)
            
        } else {
            imageURL = nil
        }
        
        guard let priceApp = prices[Keys.priceApp] as? String,
            let appDescription = descriptionApp[Keys.appDescription] as? String,
            let title = name[Keys.nameApp] as? String
            else {
                return nil
        }
        
        
        self.imageURL = imageURL
        self.title = title
        self.priceApp = priceApp
        self.appDescription = appDescription
    }
    
    public init(imageURL: URL?,
                priceApp: String,
                appDescription: String,
                title: String) {
        
        self.imageURL = imageURL
        self.title = title
        self.priceApp = priceApp
        self.appDescription = appDescription
        
    }
    
    // MARK: - Class Constructors
    public class func array(jsonArray: [[String: Any]]) -> [ItemApp] {
        var array: [ItemApp] = []
        for json in jsonArray {
            guard let product = ItemApp(json: json) else { continue }
            array.append(product)
        }
        return array
    }
}
