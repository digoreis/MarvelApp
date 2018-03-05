//
//  CharactersDatabase.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 01/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

class CharactersDatabase {
    static let shared = CharactersDatabase()

    fileprivate var items = Set<Character>()
    public var favoriteID : Int?

    init() {
        let defaults = UserDefaults.standard
        self.favoriteID = defaults.integer(forKey: "MarvelAppFavoriteID") == 0 ? nil :  defaults.integer(forKey: "MarvelAppFavoriteID")
    }

    public func hasFavorite() -> Bool {
        return self.favoriteID != nil
    }

    public func addItem(_ item: Character) -> Bool {
        let result = items.insert(item)
        return result.inserted
    }

    public func addItems(characters: [Character]) {
        self.items = self.items.union(characters)
    }

    public func removeItem(_ item: Character) -> Bool {
        return (items.remove(item) != nil)
    }

    public func getItems() -> [Character] {
        return Array(self.items)
    }

    public func clean() {
        self.items = Set<Character>()
    }

    deinit {
        let defaults = UserDefaults.standard
        defaults.set(favoriteID, forKey: "MarvelAppFavoriteID")
    }


}
