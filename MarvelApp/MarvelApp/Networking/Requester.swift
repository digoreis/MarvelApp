//
//  ApiRequester.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 27/02/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

enum RequestResult {
    case sucess(Codable?)
    case error(Error)
}

enum NetworkingError : Error {
    case noData
    case noHttpError
    case notFound
    case internalError
}

protocol Requestable {
    static func get(_ request: Request, callback: @escaping (RequestResult) -> Void)
}

class Requester<T : Codable>: Requestable {

    static func get(_ request: Request, callback: @escaping (RequestResult) -> Void) {
        guard let url = request.generateURL() else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                if let r = response {
                    callback(.error(self.httpError(r)))
                } else {
                    callback(.error(NetworkingError.noHttpError))
                }
                return
            }
            guard let data = data else { callback(.error(NetworkingError.noData)) ; return }
            do {
                let jsonObject = try JSONDecoder().decode(PayloadRequest<T>.self, from: data)
                callback(.sucess(jsonObject))
            } catch let error{
                callback(.error(NetworkingError.noHttpError))
                print(error)
            }
        }
        task.resume()
    }

    static func httpError(_ response: URLResponse) -> NetworkingError {
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
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData
    }
}
