//
//  ChuckFactsTests.swift
//  ChuckFactsTests
//
//  Created by Luiz Fernando dos Santos on 10/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import XCTest
import Pods_Chuck_Facts

@testable import Chuck_Facts

class ChuckFactsTests: XCTestCase {

    let jsonCategoryNil:[String: Any?] = ["category" : nil,
                           "icon_url" : "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
                           "id" : "h07CQEgCS_eVXB9lwtLoCw",
                           "url" : "https://api.chucknorris.io/jokes/h07CQEgCS_eVXB9lwtLoCw",
                           "value" : "Chuck Norris can win a game of rock-paper-scissors with his boot."]

    let jsonOK: [String: Any] =  ["category" : [ "movie"],
                                  "icon_url" : "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
                                  "id" : "h07CQEgCS_eVXB9lwtLoCw",
                                  "url" : "https://api.chucknorris.io/jokes/h07CQEgCS_eVXB9lwtLoCw",
                                  "value" : "Chuck Norris can win a game of rock-paper-scissors with his boot."]

    override func setUp() {
    }

    override func tearDown() {
    }

    func testNilCategory() {

        let fact = Fact.decode(from: jsonCategoryNil)

        XCTAssertEqual(fact?.category, nil)
    }

    func testDecodeFact() {

        if let fact = Fact.decode(from: jsonOK) {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }

    func testUncategorizedViewModel() {

        let fact = Fact.decode(from: jsonCategoryNil)
        let factViewModel = FactViewModel(fact: fact!)

        XCTAssertEqual(factViewModel.category, Constants.Fact.UNCATEGORIZED.rawValue)
    }
}
