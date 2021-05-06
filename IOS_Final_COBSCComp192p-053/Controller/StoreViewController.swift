//
//  StoreViewController.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Dilshan Jayasekara on 2021-05-06.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    
    @IBOutlet weak var Preview: UIView!
    @IBOutlet weak var Category: UIView!
    @IBOutlet weak var Menu: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex{
                  case 0:
                    Preview.isHidden = false
                    Category.isHidden = true
                    Menu.isHidden = true
                  case 1:
                    Preview.isHidden = true
                    Category.isHidden = true
                    Menu.isHidden = false
                  case 2:
                    Preview.isHidden = true
                    Category.isHidden = false
                    Menu.isHidden = true
                   
                  default:
                    Preview.isHidden = false
                  }
        }

}
