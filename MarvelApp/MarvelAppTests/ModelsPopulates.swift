//
//  ModelsPopulates.swift
//  MarvelAppTests
//
//  Created by Rodrigo Reis on 04/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import XCTest
@testable import MarvelApp

class ModelsPopulates: XCTestCase {
        
    
    func testComic() {
        if let data = loadDataFromFile(name: "comic") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Comic.self, from: data)
                let jsonObject2 = try JSONDecoder().decode(Comic.self, from: data)
                jsonObject2.description = "TEST-POPULATE"
                jsonObject1.populate(item: jsonObject2)
                XCTAssert(jsonObject1.description == "TEST-POPULATE")
                return
            } catch let e {
                print(e)

            }
        }
        XCTAssert(false)
    }

    func testSerie() {
        if let data = loadDataFromFile(name: "serie") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Serie.self, from: data)
                let jsonObject2 = try JSONDecoder().decode(Serie.self, from: data)
                jsonObject2.description = "TEST-POPULATE"
                jsonObject1.populate(item: jsonObject2)
                XCTAssert(jsonObject1.description == "TEST-POPULATE")
                return
            } catch let e {
                print(e)

            }
        }
        XCTAssert(false)
    }

    func testEvent() {
        if let data = loadDataFromFile(name: "event") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Event.self, from: data)
                let jsonObject2 = try JSONDecoder().decode(Event.self, from: data)
                jsonObject2.description = "TEST-POPULATE"
                jsonObject1.populate(item: jsonObject2)
                XCTAssert(jsonObject1.description == "TEST-POPULATE")
                return
            } catch let e {
                print(e)

            }
        }
        XCTAssert(false)
    }

    func testStory() {
        if let data = loadDataFromFile(name: "story") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Story.self, from: data)
                let jsonObject2 = try JSONDecoder().decode(Story.self, from: data)
                jsonObject2.description = "TEST-POPULATE"
                jsonObject1.populate(item: jsonObject2)
                XCTAssert(jsonObject1.description == "TEST-POPULATE")
                return
            } catch let e {
                print(e)

            }
        }
        XCTAssert(false)
    }
    
}
