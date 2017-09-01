//
//  FactoidsTests.swift
//  FactoidsTests
//
//  Created by Thomas Le on 8/30/17.
//  Copyright © 2017 Thomas Le. All rights reserved.
//

import XCTest
import GameKit
@testable import Factoids

class FactoidsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        let count = 50
//        var index = 0
//        var factProvider = FactProvider()
//        var fact = "text"
//        while index < count {
//            
//            fact = factProvider.randomFact()
//            print("\(FactProvider().getFactOrFake()) :  \(fact)")
//            index += 1
//            
//        }
        
        let count = 50
        var index = 0
        while index < count {
            
            print(GKRandomSource.sharedRandom().nextInt(upperBound: 2))
            index += 1
            
        }
    }
    
    func testRandomNum() {
        
        let count = 50
        var index = 0
        while index < count {
            
            print(GKRandomSource.sharedRandom().nextInt(upperBound: 2))
            index += 1
            
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
