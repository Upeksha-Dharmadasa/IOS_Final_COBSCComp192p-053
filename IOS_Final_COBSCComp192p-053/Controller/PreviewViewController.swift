//
//  PreviewViewController.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Dilshan Jayasekara on 2021-05-07.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage
struct FoodItem{
    var FId:String
    var FName:String
    var FDescription:String
    var FPrice:Double
    var FImage:String
    var FCategory:String
    var FActive:Bool
    enum CodingKeys: String, CodingKey {
         case FId
        case FName
        case FDescription
        case FPrice
        case FImage
        case FCategory
        case FActive
        }
}

struct GroupItem{
    var key:String
    var item:[FoodItem]
}

class PreviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ViewFood: UITableView!
    var ref = Database.database().reference()
        var foodItem: [FoodItem] = [
          
       ]
        
        var groupItems: [GroupItem] = [
        
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewFood.delegate = self;
        ViewFood.dataSource = self;
        getFoodData();
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           groupItems.count
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return groupItems[section].item.count
       }
       
      
       
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           if(groupItems.count > 0){
               return groupItems[section].key
           }
           return ""
           
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ViewFood.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! PreviewTableViewCell
        cell.lblFoodName.text = groupItems[indexPath.section].item[indexPath.row].FName;
        cell.lblDescription.text = groupItems[indexPath.section].item[indexPath.row].FDescription;
        cell.lblPrice.text  = String(groupItems[indexPath.section].item[indexPath.row].FPrice ?? 0);
        if let url = URL(string: self.groupItems[indexPath.section].item[indexPath.row].FImage ) {
            cell.imgFood.af_setImage(withURL: url)
            }
        
        return cell;
    }
    
    func getFoodData(){
            ref.child("FoodMaster").observe(.value, with:{
                (snapshot) in
                if let data = snapshot.value {
                    if let foodItems = data as? [String: Any]{
                        self.foodItem.removeAll()
                        self.groupItems.removeAll()
                        for itemInfo in foodItems {
                            if let val = itemInfo.value as? [String: Any]{
                                let item = FoodItem(FId: val["FId"] as! String,FName: val["FName"] as! String, FDescription: val["FDescription"] as! String, FPrice: val["FPrice"] as! Double, FImage: val["FImage"] as! String, FCategory: val["FCategory"] as! String, FActive: val["FActive"] as! Bool)
                                self.foodItem.append(item)
                                    
                                        }
                                    }
                        
                                    let groupByCategory = Dictionary(grouping: self.foodItem) { (items) -> String in
                                        return items.FCategory
                                        }
                     
                                        groupByCategory.forEach({(key,val) in
                     
                                            self.groupItems.append(GroupItem.init(key: key, item: val))
                                        })
                        self.ViewFood.reloadData()
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
