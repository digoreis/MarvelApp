//
//  Support.swift
//  MarvelAppTests
//
//  Created by Rodrigo Reis on 04/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation
import XCTest
@testable import MarvelApp

extension XCTestCase {
    func loadDataFromFile(name: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: name, withExtension: "json")

        let data = try? Data(contentsOf: url!)
        return data
    }
}

class CharactersProviderDelegateMock : CharactersProviderDelegate {

    func searchResult(data: [MarvelApp.Character]?, error: Error?) {
        guard error == nil else { print(error ?? "") ; self.expectation.fulfill() ; return }
        self.dataSearch = data
        self.expectation.fulfill()
    }

    func finishFavoriteCharacter(data: MarvelApp.Character?, error: Error?) {
        self.dataFavorite = data
        self.expectation.fulfill()
    }


    func finishLoadPage(error: Error?) {
        guard error == nil else { print(error ?? "") ; self.expectation.fulfill() ; return }
        self.expectation.fulfill()
    }


    let expectation: XCTestExpectation

    var dataSearch : [MarvelApp.Character]?
    var dataFavorite : MarvelApp.Character?

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
}

class SerieMutable: Codable, ResourceURIRequestable {

    var resourceURI: String
    let name: String?
    var id: Int?
    var title: String?
    var description: String?
    var urls: [Url]?
    var startYear: Int?
    var endYear: Int?
    var rating: String?
    var modified: String?
    var thumbnail: Thumbnail?
    var next: Serie?
    var previous: Serie?

    func isLoaded() -> Bool {
        return (title != nil)
    }

    func populate(item: SerieMutable) {
        self.id = item.id
        self.title = item.title
        self.description = item.description
        self.urls = item.urls
        self.startYear = item.startYear
        self.endYear = item.endYear
        self.rating = item.rating
        self.modified = item.modified
        self.thumbnail = item.thumbnail
        self.next = item.next
        self.previous = item.previous
    }
}
