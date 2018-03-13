//
//  AppTableViewCell.swift
//  ListApp
//
//  Created by DavidFresh on 3/12/18.
//  Copyright © 2018 davidfresh. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell {

    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var lblPriceApp: UILabel!
    @IBOutlet weak var lblNameApp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
