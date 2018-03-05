//
//  Serie.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 03/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

class Serie: Codable, ResourceURIRequestable {

    let resourceURI: String
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

    func populate(item: Serie) {
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
