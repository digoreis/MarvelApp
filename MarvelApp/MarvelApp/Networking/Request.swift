//
//  Request.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 27/02/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation
import ReSwift

extension Date {
    func toMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
struct Request {
    var path: String
    let params: [String: String]
    let baseURL = "https://gateway.marvel.com:443"
    let publicApiKey = "343cf83f216a0ef6b197e69636fef8c6"
    let privateApiKey = "686e604535fe02dce56f6f994a9d30c075dc4c79"
    let timestamp = "\(Date().toMillis())"
}

// MARK: - Request Behaviour
extension Request {
    func generateURL() -> URL? {
        let cleanpath = self.path.replacingOccurrences(of: "http://gateway.marvel.com", with: "")
        return URL(string: "\(baseURL)\(cleanpath)\(generateParams())")
    }

    fileprivate func generateParams() -> String {
        var newParams = self.params
        newParams["apikey"] = self.publicApiKey
        newParams["hash"] = self.hash()
        newParams["ts"] = self.timestamp

        let itemsToJoin = newParams.flatMap { (key, value) -> String? in
            let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
            return "\(key)=\(encodedValue)"
        }
        let joinedValues = itemsToJoin.joined(separator: "&")
        return "?\(joinedValues)"
    }

    func hash() -> String {
        let md5 = MD5(string: "\(self.timestamp)\(self.privateApiKey)\(self.publicApiKey)")
        return md5.map { String(format: "%02hhx", $0) }.joined()
    }

    private func MD5(string: String) -> Data {
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
