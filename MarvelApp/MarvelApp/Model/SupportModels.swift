//
//  SupportModels.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 03/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    var path : String
    var `extension` : String
}

struct DateObject: Codable {
    let type: String
    let date: String
}

struct Url: Codable {
    var type : String
    var url : String
}
