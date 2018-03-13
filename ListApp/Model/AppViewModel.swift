//
//  AppViewModel.swift
//  ListApp
//
//  Created by DavidFresh on 3/12/18.
//  Copyright © 2018 davidfresh. All rights reserved.
//

import UIKit


public final class AppViewModel {
    
 
    // MARK: - Instance Properties
    public let itemApp: ItemApp
    
    public let descriptionText: String
    public let imageURL: URL?
    public let priceText: String
    public let titleText: String
    
    // MARK: - Object Lifecycle
    public init(app: ItemApp) {
        
        self.itemApp = app
        priceText = app.priceApp
        descriptionText = app.appDescription
        imageURL = app.imageURL
        titleText = app.title
    }
}

