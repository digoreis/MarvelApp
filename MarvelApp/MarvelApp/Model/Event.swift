//
//  Event.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 03/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

class Event: Codable, ResourceURIRequestable {


    let resourceURI: String
    let name: String?
    var id: Int?
    var title: String?
    var description: String?
    var urls: [Url]?
    var modified: String?
    var start: String?
    var end: String?
    var thumbnail: Thumbnail?
    var next: Event?
    var previous: Event?

    func isLoaded() -> Bool {
        return (title != nil)
    }

    func populate(item: Event) {
        self.id = item.id
        self.title = item.title
        self.description = item.description
        self.urls = item.urls
        self.modified = item.modified
        self.start = item.start
        self.end = item.end
        self.thumbnail = item.thumbnail
        self.next = item.next
        self.previous = item.previous
    }
}
