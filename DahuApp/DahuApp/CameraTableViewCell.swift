//
//  CameraTableViewCell.swift
//  DahuApp
//
//  Created by  Trung Trinh on 2/23/16.
//  Copyright © 2016 Le Minh Tu. All rights reserved.
//

import UIKit

class CameraTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var switchOn: UISwitch!
    @IBOutlet weak var cameraDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
