//
//  OrderViewController.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Dilshan Jayasekara on 2021-05-08.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

public struct NewOrder: Codable {
    let Oid : String?
    let Cname : String?
    let Ostatus : String?

    enum CodingKeys: String, CodingKey {
        case Oid
        case Cname
        case Ostatus
    }
}

public struct ReadyOrder: Codable {
    let Oid : String?
    let Cname : String?
    let Ostatus : String?

    enum CodingKeys: String, CodingKey {
        case Oid
        case Cname
        case Ostatus
    }
}

import UIKit
import Firebase
class OrderViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet weak var ViewOrder: UITableView!
    var newOrders = [NewOrder]()
    var readyOrders = [ReadyOrder]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewOrder.delegate = self;
        ViewOrder.dataSource = self;
        getOrderDetails();
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0)
        {
            return "Ready"
        }
        else
        {
            return "New"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return readyOrders.count
        }
        else
        {
            return newOrders.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderCell = ViewOrder.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
        if(indexPath.section == 0)
        {
            orderCell.lblOrderID.text = readyOrders[indexPath.row].Oid;
            orderCell.lblCustomerName.text = readyOrders[indexPath.row].Cname;
            orderCell.btnAccept.tag = Int(readyOrders[indexPath.row].Oid ?? "0") ?? 0
            orderCell.btnReject.tag = Int(readyOrders[indexPath.row].Oid ?? "0") ?? 0
            orderCell.btnAccept.backgroundColor = UIColor.orange
            orderCell.btnAccept.setTitle(readyOrders[indexPath.row].Ostatus, for: .normal)
            orderCell.btnReject.isHidden = true;
            
        }
        else
        {
            orderCell.lblOrderID.text = newOrders[indexPath.row].Oid;
            orderCell.lblCustomerName.text = newOrders[indexPath.row].Cname;
            orderCell.btnAccept.tag = Int(newOrders[indexPath.row].Oid ?? "0") ?? 0
            orderCell.btnReject.tag = Int(newOrders[indexPath.row].Oid ?? "0") ?? 0
            orderCell.isEditing = false;
        }
        return orderCell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section);
        if(indexPath.section == 0)
        {
            UserDefaults.standard.set(readyOrders[indexPath.row].Oid, forKey: "OrderId")
            UserDefaults.standard.set(readyOrders[indexPath.row].Ostatus, forKey: "Status")
            UserDefaults.standard.set(readyOrders[indexPath.row].Cname, forKey: "CusName")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ORDER_DETAILS") as! OrderDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true, completion: nil)
        }
    }
    func getOrderDetails()
    {
        let ref = Database.database().reference()
        ref.child("OrderMaster").observe(.value, with:{
            (snapshot) in
            if let data = snapshot.value {
                if let Orders = data as? [String: Any]{
                    self.newOrders.removeAll();
                    self.readyOrders.removeAll();
                    for item in Orders {
                        if let orderInfo = item.value as? [String: Any]{
                            print(orderInfo)
                                    let status = orderInfo["Ostatus"] as? String;
                                        if( "NEW" == status)
                                        {
                                            self.newOrders.append(NewOrder(Oid: orderInfo["Oid"] as? String,Cname: orderInfo["Cname"] as? String, Ostatus: orderInfo["Ostatus"] as? String));
                                        }
                                        else if("PREPARATION" == status || "READY" == status || "ARRIVING" == status){
                                            self.readyOrders.append(ReadyOrder(Oid: orderInfo["Oid"] as? String,Cname: orderInfo["Cname"] as? String, Ostatus: orderInfo["Ostatus"] as? String));
                                        }
                                        else{
                                            
                                        }
                                    }
                                }
                    self.ViewOrder.reloadData();
                          }
                    }
             })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
