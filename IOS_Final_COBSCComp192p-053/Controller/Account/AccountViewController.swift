//
//  AccountViewController.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Minidu Wickramaarachchi on 2021-05-13.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit
import Firebase

public struct Recipt: Codable {
    let id   : String?
    let date : String?
    var food : String?
    var price : Double?
    let total : Double?
    

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case food
        case price
        case total
    }
}

public struct Item: Codable {
    let item : String?
    let price : String?
    
    enum CodingKeys: String, CodingKey {
        case item
        case price
    }
}

class AccountViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateTimepic: UIDatePicker!
    @IBOutlet weak var tblAccountView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    var ref = Database.database().reference()
        var recipts = [Recipt]()
        var items = [Item]()
        var cellitem :String!
        var cellprice :String!
        var item = "";
        var price = "";
        var total = 0.0;
    override func viewDidLoad() {
        super.viewDidLoad()
        tblAccountView.delegate = self;
        tblAccountView.dataSource = self;
        getReciptDetails()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnPrintClick(_ sender: Any) {
        var markuptext=""
                     

                      
                for value in recipts{
                    markuptext += "<tr> <td> \(String(value.date ?? "")) </td> <td> \(String(value.food ?? "")) </td> <td> \(String(value.price ?? 0)) </td> </tr>"
                              
                      }
                      
                      var temp="<center><table><tr><th>Date</th><th>Name</th><th>Price</th></tr>\(markuptext)</table></center>"
                          printRecipt(text: temp)
    }
    func printRecipt(text:String){
                    let printInfo = UIPrintInfo(dictionary:nil)
                    printInfo.outputType = UIPrintInfo.OutputType.grayscale
                    printInfo.jobName = "Order Details"
                    printInfo.orientation = .portrait

                    let printController = UIPrintInteractionController.shared
                    printController.printInfo = printInfo
                    printController.showsNumberOfCopies = false
                        
                    let formatter = UIMarkupTextPrintFormatter(markupText: text)
                    printController.printFormatter = formatter
                    
                    printController.present(animated: true, completionHandler: nil)
        }
    
    @IBAction func btnSearchClick(_ sender: Any) {
        getReciptDetails();
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let reciptCell = tblAccountView.dequeueReusableCell(withIdentifier: "ReciptItemCell", for: indexPath) as! AccountTableViewCell
            reciptCell.lblOrderDate.text = recipts[indexPath.row].date;
            reciptCell.lblItem.text = recipts[indexPath.row].food;
            reciptCell.lblPrice.text = String(recipts[indexPath.row].price ?? 0);
            reciptCell.lblTotal.text = String(recipts[indexPath.row].total ?? 0);
            return reciptCell
        }
    func getReciptDetails(){
            recipts.removeAll();
            self.total = 0.0;
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY/MM/dd"
            var d1=dateFormatter.string(from: dateTimepic.date);
            
            ref.child("OrderMaster").observe(.value, with:{
                (snapshot) in
                if let data = snapshot.value {
                    if let orders = data as? [String: Any]{
                        self.recipts.removeAll();
                        self.total = 0.0;
                        for order in orders {
                            if let OrderInfo = order.value as? [String: Any]{
                                print(d1);
                                if(d1 == OrderInfo["Date"] as? String && "Confirmed" == OrderInfo["Ostatus"] as? String){
                                self.recipts.append(Recipt(id: OrderInfo["Oid"] as? String, date:  OrderInfo["Date"] as? String, food: OrderInfo["ItemName"] as? String, price: OrderInfo["Price"] as? Double, total: OrderInfo["Price"] as? Double))
                                    let tot =  OrderInfo["Price"] as? Double;
                                    self.total = self.total + (tot ?? 0) ;
                                    self.lblTotal.text = "Rs. \(self.total as! Double)"
                                }
                                else{
                                    self.total = 0.0;
                                    self.lblTotal.text = "Rs. 0.00"
                                }
                                        }
                                    }
                                    self.tblAccountView.reloadData()
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
