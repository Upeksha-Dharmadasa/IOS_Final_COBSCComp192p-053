//
//  IOS_Final_COBSCComp192p_053UITests.swift
//  IOS_Final_COBSCComp192p-053UITests
//
//  Created by Upeksha Dharmadasa on 4/30/21.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import XCTest

//private extension XCUIApplication{
//
//    var txtEmail: XCUIElement{self.textFields["txtEmail"]}
//    var txtPassword: XCUIElement{self.secureTextFields["txtPassword"]}
//    var btnLogin: XCUIElement{self.buttons["btnLogin"]}
//    var segmentPreview: XCUIElement{self.segmentedControls["Preview"]}
//
//   }
//
//class LoginTest: XCTestCase{
//    private var result: XCTestExpectation!
//    var userFound = false
//
//    func testLogin(){
//        let app = XCUIApplication()
//        app.launch()
//
//        app.txtEmail.tap()
//        app.txtEmail.typeText("upekshad123@gmail.com")
//        app.txtPassword.tap()
//        app.txtPassword.typeText("Shadow123")
//
//        app.btnLogin.tap()
//
//    }
//}


class IOS_Final_COBSCComp192p_053UITests: XCTestCase {
   
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
