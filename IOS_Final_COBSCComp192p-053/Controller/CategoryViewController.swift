//
//  CategoryViewController.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Dilshan Jayasekara on 2021-05-07.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit
import Firebase

public struct Category: Codable {
    let categoryId   :String?
    let categoryName :String?
    
    enum CodingKeys: String, CodingKey {
        case categoryId
        case categoryName
    }
}
class CategoryViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var CategoryView: UITableView!
    
    var ref = Database.database().reference()
    var category = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad();
        getDetails();
        CategoryView.delegate = self;
        CategoryView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    @IBAction func btnAdd(_ sender: Any) {
        addCategoey();
        getDetails();
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoryView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.lblCategory.text = self.category[indexPath.row].categoryName;
        return cell;
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
        }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if (editingStyle == .delete) {
                let alert = UIAlertController(title: "Confirm", message: "Are you sure want to delete the category?", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.deleteCategory(id: self.category[indexPath.row].categoryId ?? "")
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                present(alert, animated: true, completion: nil)
            }
          
            self.CategoryView.reloadData();
        }
    func deleteCategory(id:String){
        let ref = Database.database().reference()
        ref.child("CategoryMaster").child("\(id)").removeValue();
        getDetails();
        }
    
    func getDetails(){
        self.CategoryView.reloadData();
        let ref = Database.database().reference()
               ref.child("CategoryMaster").observe(.value, with:{
                   (snapshot) in
                               
                   if let data = snapshot.value {
                       if let categoryItems = data as? [String: Any]{
                        self.category.removeAll();
                           for itemInfo in categoryItems {
                               if let foodInfo = itemInfo.value as? [String: Any]{
                                   let new = Category(
                                       categoryId: itemInfo.key, categoryName: foodInfo["Cname"] as? String)
                                            self.category.append(new)
                                           }
                                       }
                                    
                                 }
                                self.CategoryView.reloadData();
                           }
                
                
                    }
               )
        
    }
    func addCategoey()
    {
        let randomInt = Int.random(in: 1..<10000)
              if (txtName.text == "") {
                  let alert = UIAlertController(title: "Failed", message: "Please Enter Category Name", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                  self.present(alert, animated: true, completion: nil)
                  return;
              }
              else{
                  self.ref.child("CategoryMaster").child("\(randomInt)").setValue(["Cname": self.txtName.text!])
                  let alert = UIAlertController(title: "Success", message: "Catogary Added Successfully..!", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                  self.present(alert, animated: true, completion: nil)
                txtName.text="";
              }
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
