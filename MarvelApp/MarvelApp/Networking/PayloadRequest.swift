//
//  File.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 03/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

struct PayloadData<T: Codable> : Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results : [T]
}
struct PayloadRequest<T: Codable>: Codable {
    let code: Int
    let status: String
    let etag: String
    let data: PayloadData<T>

}
