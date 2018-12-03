//
//  PizzaPlacesTests.swift
//  PizzaPlacesTests
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import XCTest
@testable import PizzaPlaces

class PizzaPlacesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let api = PPApiHandler.init(environment: PPEnvironments.productionEnv)
        let expectations = expectation(description: "callbacks")
        expectations.expectedFulfillmentCount = 2
        api.getFriendsList { (friends, error) in
            expectations.fulfill()
        }
        
        api.getResturantsList { (resturants, error) in
            expectations.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

}
