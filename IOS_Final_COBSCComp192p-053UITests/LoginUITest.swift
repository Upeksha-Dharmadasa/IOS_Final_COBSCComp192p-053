//
//  LoginUITest.swift
//  IOS_Final_COBSCComp192p-053UITests
//
//  Created by Dilshan Jayasekara on 2021-05-09.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import XCTest

class LoginUiTest: XCTestCase {
    
    override func setUp() {
        
        continueAfterFailure = false
    }
        func testUILogin(){
        let app = XCUIApplication()
        app.launch()
        
        let emailField = app.textFields["emailtext"]
        let passwordField = app.secureTextFields["passwordtext"]
        let btn = app.buttons["btnLogin"]
        
        emailField.tap()
        emailField.typeText("upekshad123@gmail.com")
        
        passwordField.tap()
        passwordField.typeText("Shadow123")
        
        btn.tap()
        
    }
    
}

