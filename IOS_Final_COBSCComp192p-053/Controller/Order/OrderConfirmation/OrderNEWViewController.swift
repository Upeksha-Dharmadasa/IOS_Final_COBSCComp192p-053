////
////  OrderNEWViewController.swift
////  IOS_Final_COBSCComp192p-053
////
////  Created by Dilshan Jayasekara on 2021-05-09.
////  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
////
//
//import UIKit
//import Firebase
//import FirebaseDatabase
//
//public struct ConfirmOrder: Codable {
//    let id : String?
//    let cusName : String?
//    let status : String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case cusName
//        case status
//    }
//}
//
//public struct ReadyOrder: Codable {
//    let id : String?
//    let cusName : String?
//    let status : String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case cusName
//        case status
//    }
//}
//
//public struct DispatchOrder: Codable {
//    let id : String?
//    let cusName : String?
//    let status : String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case cusName
//        case status
//    }
//}
//
//
//class OrderNEWViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    @IBOutlet weak var ViewOrder: UITableView!
//    var ConfirmOrders = [ConfirmOrder]()
//    var ReadyOrders = [ReadyOrder]()
//    var DispatchOrders = [DispatchOrder]()
//    var reference = Database.database().reference()
//
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//        }
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//}
