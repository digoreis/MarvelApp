//
//  MarvelAppTests.swift
//  MarvelAppTests
//
//  Created by Rodrigo Reis on 27/02/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import XCTest
@testable import MarvelApp

class CharactersRequesterTests: XCTestCase {

    func testCall() {
        let expectation = self.expectation(description: "NetworkingRequest1")
        let mock = CharactersProviderDelegateMock(expectation: expectation)
        let provider = CharactersProvider(delegate: mock)
        provider.getPage()
        waitForExpectations(timeout: 30, handler: nil)
    }
}
