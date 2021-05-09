//
//  IOS_Final_COBSCComp192p_053Tests.swift
//  IOS_Final_COBSCComp192p-053Tests
//
//  Created by Upeksha Dharmadasa on 4/30/21.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import XCTest
@testable import IOS_Final_COBSCComp192p_053

class IOS_Final_COBSCComp192p_053Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func TestLoginValdation() throws {
        
        //Testing a valid Email
        XCTAssertTrue(InputFieldValidator.isValidEmail("upekshad123@gmail.com"))
        
        //Testing a invalid Email
        XCTAssertFalse(InputFieldValidator.isValidEmail("idu@_gmail.com"))
        
        //Testing a invalid Email
        XCTAssertFalse(InputFieldValidator.isValidEmail("idu@_gmail.123"))
        
        //Testing a valid password
        XCTAssertTrue(InputFieldValidator.isValidPassword(pass: "Shadow123", minLength: 6, maxLength: 20))
        
        //Testing a invalid password
        XCTAssertTrue(InputFieldValidator.isValidPassword(pass: "abc", minLength: 6, maxLength: 20))
        
        //Testing a invalid password
        XCTAssertTrue(InputFieldValidator.isValidPassword(pass: "ancfnvfnvifnvejr568783t0853tvfjnvfjsnv@fvff48", minLength: 6, maxLength: 20))
        
    }
    
     
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

