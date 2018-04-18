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

    fileprivate var items = [Character]()
    public var favoriteID: Int? {
        didSet {
            saveLocal()
        }

    }

    init() {
        let defaults = UserDefaults.standard
        self.favoriteID = defaults.integer(forKey: "MarvelAppFavoriteID") == 0 ?
            nil :  defaults.integer(forKey: "MarvelAppFavoriteID")
    }

    public func hasFavorite() -> Bool {
        return self.favoriteID != nil
    }

    public func addItem(_ item: Character) -> Bool {
        items.append(item)
        return true
    }

    public func addItems(characters: [Character]) {
        self.items.append(contentsOf: characters)
    }

    public func removeItem(_ item: Character) -> Bool {
        guard let index = items.index(of: item) else { return false}
        items.remove(at: index)
        return true
    }

    public func getItems() -> [Character] {
        return self.items
    }

    public func count() -> Int {
        return self.items.count
    }

    public func get(index: Int) -> Character? {
        guard index < self.items.count else { return nil }
        return  self.items[index]
    }

    public func clean() {
        self.items = [Character]()
    }

    private func saveLocal() {
        let defaults = UserDefaults.standard
        defaults.set(favoriteID, forKey: "MarvelAppFavoriteID")
    }
}
