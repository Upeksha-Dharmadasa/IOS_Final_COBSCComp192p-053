//
//  OrderDetailsViewController.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Dilshan Jayasekara on 2021-05-08.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
public struct Items: Codable {
    let ItemName :String?
    let Price :Int?
    let Qty :Int?
    
    enum CodingKeys: String, CodingKey {
        case ItemName
        case Price
        case Qty
    }
}

class OrderDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tblOrderInfo: UITableView!
    @IBOutlet weak var lblUserInfo: UILabel!
    @IBOutlet weak var lblArivalTime: UILabel!
    var items = [Items]();
        var ref: DatabaseReference!
        let OrderId = UserDefaults.standard.string(forKey: "OrderId")
        let CustomerName = UserDefaults.standard.string(forKey: "CustomerName")
        var Longitude = 0.00;
        var Latitude = 0.00;
        var TimeRemaining = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblOrderInfo.delegate = self;
        tblOrderInfo.dataSource = self;
        getItemDetails()
        getLocationDetails()

    }
    
    @IBAction func btnback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getItemDetails() {
            
            let ref = Database.database().reference()
            ref.child("OrderMaster").child("\(OrderId ?? "")").child("items").observe(.value, with:{
                (snapshot) in
                            
                if let data = snapshot.value {
                    if let orderditems = data as? [String: Any]{
                        self.items.removeAll();
                        for itemInfo in orderditems {
                            if let orderditems = itemInfo.value as? [String: Any]{
                                let singleFoodItem = Items(
                                    ItemName: orderditems["ItemName"] as? String, Price: orderditems["Price"] as? Int, Qty: orderditems["Qty"] as! Int)
                                self.items.append(singleFoodItem)
                                        }
                                    }
                                    self.tblOrderInfo.reloadData()
                                }
                            }
                        })
                    }
    func getLocationDetails() {
             print("\(OrderId ?? "")")
             let ref = Database.database().reference()
             ref.child("OrderMaster").child("\(OrderId ?? "")").child("Location").observe(.value, with:{
                 (snapshot) in
                 if let data = snapshot.value {
                     if let LocationDetails = data as? [String: Any]{
                         for itemInfo in LocationDetails {
                            self.calTime(latitude: (LocationDetails["Latitude"] as! NSString).doubleValue, longitude: (LocationDetails["Longitude"] as! NSString).doubleValue);
                            //print(self.Longitude)
                                     }
                                     self.tblOrderInfo.reloadData()
                                 }
                 }
                })
        }
    func calTime(latitude: Double, longitude: Double){
            if(latitude > 65.78 && longitude > 45.45){
                TimeRemaining = "5 min"
            }
            else{
                TimeRemaining = "3 min"
            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print(tableView);
            print("Row At: \( self.items.count)")
            return items.count;
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
                let Ordercell = tblOrderInfo.dequeueReusableCell(withIdentifier: "InfoViewCell", for: indexPath) as! OrderDetailTableViewCell
            Ordercell.lblQty.text = "\(self.items[indexPath.row].Qty ?? 0) x";
            Ordercell.lblItemName.text = self.items[indexPath.row].ItemName;
            Ordercell.lblPrice.text = "Rs.\(self.items[indexPath.row].Price ?? 0).00";
            lblUserInfo.text = "\(CustomerName ?? "") (\(OrderId ?? ""))";
            lblArivalTime.text = TimeRemaining;
                return Ordercell;
            //print(TimeRemaining)
        }
   
}
