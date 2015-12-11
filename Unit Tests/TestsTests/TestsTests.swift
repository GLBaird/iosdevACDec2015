//
//  TestsTests.swift
//  TestsTests
//
//  Created by Leon Baird on 18/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import XCTest
@testable import Tests

class TestsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainViewController() {
        let mainVC = ViewController()
        
        XCTAssertTrue(mainVC.getValue(10) == 20, "getVal failed to produce x2 Int Value")
        XCTAssertTrue(mainVC.getName().dynamicType == String.self, "getName failed to return an instance of String")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
