//
//  Character.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 27/02/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

struct CharacterComics: Codable {
    var available: Int
    var collectionURI: String
    var items: [Comic]
}

struct CharacterSeries: Codable {
    var available: Int
    var collectionURI: String
    var items: [Serie]
}

struct CharacterEvents: Codable {
    var available: Int
    var collectionURI: String
    var items: [Event]
}

struct CharacterStories: Codable {
    var available: Int
    var collectionURI: String
    var items: [Story]
}

struct Character: Hashable, Codable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    let id: Int
    let name: String
    let description: String?
    let modified: String
    let thumbnail: Thumbnail?
    let resourceURI: String
    let comics: CharacterComics?
    let series: CharacterSeries?
    let stories: CharacterStories?
    let events: CharacterEvents?
    let urls: [Url]?

    public var hashValue: Int { return id }
}
