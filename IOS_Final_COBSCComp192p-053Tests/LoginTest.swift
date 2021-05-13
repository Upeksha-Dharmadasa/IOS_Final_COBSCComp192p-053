//
//  LoginTest.swift
//  IOS_Final_COBSCComp192p-053
//
//  Created by Minidu Wickramaarachchi on 2021-05-13.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import Foundation
import XCTest
class LoginTest: XCTestCase {

    let authenticationService = AuthenticationService()
    func ValidEmailTesting(){
        let result = authenticationService.validateEmail(email: "upekshad123@gmail.com")
        XCTAssertEqual(result, true)
    }
    
    func InvalidEmailTesting(){
        let result = authenticationService.validateEmail(email: "123abc.com.nibm")
               XCTAssertEqual(result, false)
    }
    
    func ValidPasswordTesting(){
        let result = authenticationService.isValidPassword(pwd: "Shadow1997")
        XCTAssertEqual(result, true)
    }
    
    func InvalidPasswordTesting(){
        let result = authenticationService.isValidPassword(pwd: "4835935vjnf@c944nfb49dno")
               XCTAssertEqual(result, false)
    }

}
