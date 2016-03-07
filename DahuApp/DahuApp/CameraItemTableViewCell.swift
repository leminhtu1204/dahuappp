//
//  CameraItemTableViewCell.swift
//  DahuApp
//
//  Created by Le Minh Tu on 3/6/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class CameraItemTableViewCell: UITableViewCell {

    @IBOutlet weak var cameraName: UILabel!
    @IBOutlet weak var cameraImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
