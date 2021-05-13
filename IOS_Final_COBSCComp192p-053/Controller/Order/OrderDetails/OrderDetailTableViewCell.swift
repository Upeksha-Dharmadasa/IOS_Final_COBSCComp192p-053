//
//  OrderDetailTableViewCell.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Dilshan Jayasekara on 2021-05-09.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {
    

    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
