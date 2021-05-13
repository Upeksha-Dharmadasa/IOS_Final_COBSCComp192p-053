//
//  OrderTableViewCell.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Minidu Wickramaarachchi on 2021-05-13.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit
import Firebase

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var CusName: UILabel!
    @IBOutlet weak var OrderId: UILabel!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    var ref = Database.database().reference()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnReject(_ sender: UIButton) {
        self.ref.child("OrderMaster/\(sender.tag)/Ostatus").setValue("Rejected")
    }
    @IBAction func btnAccept(_ sender: UIButton) {
        self.ref.child("OrderMaster/\(sender.tag)/Ostatus").setValue("Confirmed")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
