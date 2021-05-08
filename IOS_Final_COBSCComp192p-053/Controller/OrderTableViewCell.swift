//
//  OrderTableViewCell.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Dilshan Jayasekara on 2021-05-08.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit
import Firebase
class OrderTableViewCell: UITableViewCell {
    var ref = Database.database().reference()
    var count = 0;
    var status = "";
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblOrderID: UILabel!
    
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func ClickAccept(_ sender: UIButton) {
        if(count == 0)
        {
            self.ref.child("Orders/\(sender.tag)/status").setValue("PREPARATION")
            UserDefaults.standard.set("PREPARATION", forKey: "Status")
            count = count + 1;
        }
        else if(count == 1)
        {
            self.ref.child("Orders/\(sender.tag)/status").setValue("READY")
            UserDefaults.standard.set("READY", forKey: "Status")
            count = count + 1;
        }
        else if("ARRIVING" == UserDefaults.standard.string(forKey: "Status"))
        {
            self.ref.child("Orders/\(sender.tag)/status").setValue("DONE")
            UserDefaults.standard.set("DONE", forKey: "Status")
        }
    }
    
    @IBAction func ClickReject(_ sender: UIButton) {
        self.ref.child("Orders/\(sender.tag)/status").setValue("CANCLE")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
