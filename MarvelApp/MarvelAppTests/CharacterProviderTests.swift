//
//  CharacterProviderTests.swift
//  MarvelAppTests
//
//  Created by Rodrigo Reis on 04/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import XCTest
@testable import MarvelApp

class CharacterProviderTests: XCTestCase {

    var provider: CharactersProvider?
    var mock: CharactersProviderDelegateMock?

    override func setUp() {
        let expectation = self.expectation(description: "NetworkingRequest1")
        self.mock = CharactersProviderDelegateMock(expectation: expectation)
        self.provider = CharactersProvider(delegate: mock!)
        super.setUp()

    }

    func testSearchValid() {
        self.provider?.doSearch(name: "thor")
        waitForExpectations(timeout: 30, handler: nil)
        if let count = mock?.dataSearch?.count {
            XCTAssert(count > 0)
        }
    }

    func testSearchInvalid() {
        self.provider?.doSearch(name: "Mickey Mouse")
        waitForExpectations(timeout: 30, handler: nil)
        if let count = mock?.dataSearch?.count {
            XCTAssert(count == 0)
        }
    }

    func testLoadItems() {
        self.provider?.getPage()
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssert((self.provider?.getItems().count ?? 0) > 0)
    }

    func testSaveFavorite() {
        self.provider?.getPage()
        waitForExpectations(timeout: 30, handler: nil)
        if let char = self.provider?.getItems().first {
            self.provider?.saveFavoriteID(id: char.id)
            XCTAssert(self.provider?.getFavoriteID() == char.id)
            self.provider?.cleanFavoriteID()
            XCTAssertNil(self.provider?.getFavoriteID())
        }
    }

    func testFavoriteData() {
        self.provider?.getFavorite(id: 1011334)
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssert(self.mock?.dataFavorite?.id == 1011334)
    }

}
