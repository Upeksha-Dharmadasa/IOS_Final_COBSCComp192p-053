//
//  AddFoodViewController.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Dilshan Jayasekara on 2021-05-07.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
class AddFoodViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var FoodImage: UIImageView!
    @IBOutlet weak var pickCategory: UIPickerView!
    
    var randomInt = 0;
    var foodCategory = ""
    var imageURL = ""
    var ref = Database.database().reference()
    private let storage = Storage.storage().reference()
    var category = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCatogaryData();
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        FoodImage.isUserInteractionEnabled = true
        FoodImage.addGestureRecognizer(tapGestureRecognizer)
        self.pickCategory.delegate = self
        self.pickCategory.dataSource = self
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
        {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true)
        }
    
    @IBAction func btnAdd(_ sender: Any) {
        if(Validation())
               {
                   AddFood();
               }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
     }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row].categoryName;
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch pickerView {
                   case pickCategory:
                    self.foodCategory = category[row].categoryName ?? ""// This gives only the
            default: break
                
            }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
             randomInt = Int.random(in: 1000..<10000);
                picker.dismiss(animated: true, completion: nil)
                guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                    return
                }
                guard let imageData = image.pngData() else {
                    return
                }
        storage.child("FoodImageMaster").child("\(self.randomInt).png").putData(imageData, metadata: nil, completion: { _, error in
                    guard error == nil else {
                        print("Faild to Upload")
                        return
                    }
                    print("Upload Success")
                    self.storage.child("FoodImageMaster").child("\(self.randomInt).png").downloadURL(completion: {url, error in
                        guard let url = url, error == nil else{
                            return
                        }
                        let urlString = url.absoluteString
                        DispatchQueue.main.async {
                            self.FoodImage .image = image
                        }
                        self.imageURL = urlString;
                        print("URL: \(urlString)")
                        UserDefaults.standard.set(urlString, forKey: "url")
                    })
                    
                })
            }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
              picker.dismiss(animated: true, completion: nil)
          }
    
    func getCatogaryData() {
          
          let ref = Database.database().reference()
          ref.child("CategoryMaster").observe(.value, with:{
              (snapshot) in
                          
              if let data = snapshot.value {
                  if let categoryItems = data as? [String: Any]{
                      self.category.removeAll();
                      for itemInfo in categoryItems {
                          if let categoryInfo = itemInfo.value as? [String: Any]{
                              let new = Category(
                                  categoryId: itemInfo.key, categoryName: categoryInfo["Cname"] as? String)
                                      self.category.append(new)
                                      }
                                  }
                    self.pickCategory.reloadAllComponents();
                                 
                            }
                      }
               })
  }
    
    func AddFood(){
            randomInt = Int.random(in: 1000..<10000);
            self.ref.child("FoodMaster").child("\(self.randomInt)").setValue(
                ["FId" : "\(randomInt)",
                 "FName": self.txtName.text,
                 "FDescription": self.txtDesc.text,
                 "FPrice": Double(self.txtPrice.text ?? "0") ?? 0,
                 "FImage": self.imageURL,
                 "FCategory": self.foodCategory,
                 "FActive":true])
            let alert = UIAlertController(title: "Success", message: "Item Added Successfully", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
        }
    func Validation()->Bool{
            if(txtName.text  == "" || txtPrice.text == "" || txtDesc.text == "" )
            {
                
                let alert = UIAlertController(title: "Error", message: "Fields cannot be empty", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            else{
                return true
            }
        }

}
