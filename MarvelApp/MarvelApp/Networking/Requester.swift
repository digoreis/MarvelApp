//
//  ApiRequester.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 27/02/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

// MARK: - Enum to Result of API Calls
enum RequestResult {
    case sucess(Codable?)
    case error(Error)
}

// MARK: - Enum of Error for API call
enum NetworkingError: Error {
    case noData
    case noHttpError
    case notFound
    case parserError
    case internalError
}

// MARK: - Protocol to Define methods to a Class to be a Resquestable
protocol Requestable {
    static func get(_ request: Request, callback: @escaping (RequestResult) -> Void)
}

// MARK: - Requester Class to Abstract Payload of Marvel API
class Requester<T: Codable>: Requestable {

    static func get(_ request: Request, callback: @escaping (RequestResult) -> Void) {
        guard let url = request.generateURL() else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { callback(.error(self.httpError(response))) ; return }
            guard let data = data else { callback(.error(NetworkingError.noData)) ; return }
            do {
                let jsonObject = try JSONDecoder().decode(PayloadRequest<T>.self, from: data)
                callback(.sucess(jsonObject))
            } catch {
                callback(.error(NetworkingError.parserError))
            }
        }
        task.resume()
    }

    static func httpError(_ response: URLResponse?) -> NetworkingError {
        guard let responseHttp = response as? HTTPURLResponse else { return .noHttpError }
        let baseError = responseHttp.statusCode/100
        switch baseError {
        case 4:
            return .notFound
        case 5:
            return .internalError
        default:
            return .noHttpError
        }
    }

    func MD5(string: String) -> Data {
        let messageData = string.data(using: .utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData
    }
}
