//
//  CharactersDatabaseTests.swift
//  MarvelAppTests
//
//  Created by Rodrigo Reis on 03/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import XCTest
@testable import MarvelApp

class CharactersDatabaseTests: XCTestCase {

    let referenceDatabase = CharactersDatabase.shared

        
    func testAddItem() {
        referenceDatabase.clean()
        let c = MarvelApp.Character(id: 99, name: "Test", description: "test", modified: "", thumbnail: nil, resourceURI: "", comics: nil, series: nil, stories: nil, events: nil, urls: nil)
        XCTAssert(referenceDatabase.addItem(c))
        let items = referenceDatabase.getItems()
        XCTAssert(items.first?.id == 99)

    }

    func testRemove() {
        let c = MarvelApp.Character(id: 99, name: "Test", description: "test", modified: "", thumbnail: nil, resourceURI: "", comics: nil, series: nil, stories: nil, events: nil, urls: nil)

        XCTAssert(referenceDatabase.removeItem(c))
        let items = referenceDatabase.getItems()
        XCTAssert(items.count == 0)
    }

    func testFavorite() {
        referenceDatabase.favoriteID = nil
        XCTAssertNil(referenceDatabase.favoriteID)
        XCTAssertFalse(referenceDatabase.hasFavorite())
        referenceDatabase.favoriteID = 99
        XCTAssert(referenceDatabase.hasFavorite())
        XCTAssert(referenceDatabase.favoriteID == 99)
        referenceDatabase.favoriteID = nil
        XCTAssertNil(referenceDatabase.favoriteID)
        XCTAssertFalse(referenceDatabase.hasFavorite())
    }

    
}
