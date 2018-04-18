//
//  ResourceURIRequestTests.swift
//  MarvelAppTests
//
//  Created by Rodrigo Reis on 04/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import XCTest
@testable import MarvelApp

class ResourceURIRequestTests: XCTestCase {

    func testComicLoad() {
        let expectation = self.expectation(description: "LOAD")
        if let data = loadDataFromFile(name: "comic") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Comic.self, from: data)
                jsonObject1.load(callback: { status in
                    if status {
                        expectation.fulfill()
                    }
                })
            } catch let e {
                print(e)
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
        XCTAssert(true)
    }

    func testSerieLoad() {
        let expectation = self.expectation(description: "LOAD")
        if let data = loadDataFromFile(name: "serie") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Serie.self, from: data)
                jsonObject1.load(callback: { status in
                    if status {
                        expectation.fulfill()
                    }
                })
            } catch let e {
                print(e)
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
        XCTAssert(true)
    }

    func testEventLoad() {
        let expectation = self.expectation(description: "LOAD")
        if let data = loadDataFromFile(name: "event") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Event.self, from: data)
                jsonObject1.load(callback: { status in
                    if status {
                        expectation.fulfill()
                    }
                })
            } catch let e {
                print(e)
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
        XCTAssert(true)
    }

    func testStoryLoad() {
        let expectation = self.expectation(description: "LOAD")
        if let data = loadDataFromFile(name: "story") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Story.self, from: data)
                jsonObject1.load(callback: { status in
                    if status {
                        expectation.fulfill()
                    }
                })
            } catch let e {
                print(e)
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
        XCTAssert(true)
    }

    func testErrorLoad() {
        let expectation = self.expectation(description: "LOAD")
        if let data = loadDataFromFile(name: "serie") {
            do {
                let jsonObject1 = try JSONDecoder().decode(SerieMutable.self, from: data)
                jsonObject1.resourceURI = ""
                jsonObject1.title = nil
                jsonObject1.load(callback: { status in
                    XCTAssertFalse(status)
                    expectation.fulfill()
                })
            } catch let e {
                print(e)
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
    }
}
