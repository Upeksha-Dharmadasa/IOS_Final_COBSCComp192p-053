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
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblOrderID: UILabel!
    
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    
    @IBOutlet weak var btnTrack: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func ClickAccept(_ sender: UIButton) {
            self.ref.child("OrderMaster/\(sender.tag)/Ostatus").setValue("Ready")
        
            UserDefaults.standard.set("Ready", forKey: "Status")
    }
    
    @IBAction func ClickReject(_ sender: UIButton) {
        self.ref.child("OrderMaster/\(sender.tag)/Ostatus").setValue("CANCLE")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
