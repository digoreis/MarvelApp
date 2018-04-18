//
//  CharactersDetailViewModel.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 06/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

protocol CharactersDetailViewModelProtocol {
    func count() -> Int
    func item(index: Int) -> CharacterDetailFields?
}

class CharactersDetailViewModel: CharactersDetailViewModelProtocol {

    fileprivate var item: Character?
    fileprivate var cells =  [CharacterDetailFields]()

    init(item: Character) {
        self.item = item
        cells.append(.label("Name", item.name))
        if let desc =  item.description, !desc.isEmpty {
            cells.append(.text("Description", desc))
        }
    }

    public func count() -> Int {
        return cells.count
    }

    public func item(index: Int) -> CharacterDetailFields? {
        guard index < cells.count else { return nil }
        return cells[index]
    }

}
