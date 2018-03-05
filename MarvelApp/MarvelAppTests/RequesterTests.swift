//
//  RequesterTests.swift
//  MarvelAppTests
//
//  Created by Rodrigo Reis on 04/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import XCTest
@testable import MarvelApp

class T : Codable {
    let name: String
}

class RequesterTests: XCTestCase {

    let testMD5String = "CY9rzUYh03PK3k6DJie09g=="

    func testErrorHTTPNotFound() {
        guard let url = URL(string: "http://google.com") else { return }
        guard let error = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil) else { return }
        XCTAssert(Requester<T>.httpError(error) == .notFound)
    }

    func testErrorHTTPInternal() {
        guard let url = URL(string: "http://google.com") else { return }
        guard let error = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil) else { return }
        XCTAssert(Requester<T>.httpError(error) == .internalError)
    }

    func testHTTPSucess() {
        guard let url = URL(string: "http://google.com") else { return }
        guard let error = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else { return }
        XCTAssert(Requester<T>.httpError(error) == .noHttpError)
    }

    func testMD5() {
        let req = Requester<T>()
        XCTAssert(req.MD5(string: "test").base64EncodedString() == self.testMD5String)
    }

    func testRequesterError() {
        let request = Request(path: "@", params: [:])
        let exp = self.expectation(description: "ERRORLOAD")
        Requester<Serie>.get(request) { result in
            switch result {
            case .sucess(_):
                XCTAssert(false)
                return
            case .error(_):
                XCTAssert(true)
                exp.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
    }

}
