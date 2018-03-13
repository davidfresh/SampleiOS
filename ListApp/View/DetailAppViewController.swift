//
//  DetailAppViewController.swift
//  ListApp
//
//  Created by DavidFresh on 3/12/18.
//  Copyright © 2018 davidfresh. All rights reserved.
//

import UIKit

class DetailAppViewController: UIViewController {
    
    
    // MARK: - Injections
    public var productViewModel: AppViewModel!
    
    // MARK: - Outlets
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
      @IBOutlet var titleLabel: UILabel!
    
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = productViewModel.titleText
        descriptionLabel.text = productViewModel.descriptionText
        imageView.rw_setImage(url: productViewModel.imageURL)
        priceLabel.text = productViewModel.priceText
    }

    



}
