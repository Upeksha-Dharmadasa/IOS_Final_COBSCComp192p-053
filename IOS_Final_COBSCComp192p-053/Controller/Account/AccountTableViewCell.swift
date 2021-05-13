//
//  AccountTableViewCell.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Minidu Wickramaarachchi on 2021-05-13.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblItem: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
