//
//  CharactersProvider.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 27/02/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

// MARK: - Protocol abount behavior of provider Information about Marvel Characters ( API and Local Cache )
protocol CharactersProviderDelegate: class {
    func finishLoadPage(error: Error?)
    func searchResult(data: [Character]?, error: Error?)
    func finishFavoriteCharacter(data: Character?, error: Error?)
}

// MARK: - Implementation of Provider to Characters of Marvel API and Local Cache
class CharactersProvider {

    weak var delegate: CharactersProviderDelegate?
    private var characters : [Any]?
    private var page = 0
    private var pageSize = 20
    private var total = 0

    private var running = false

    private let pathForResource = "/v1/public/characters"

    init(delegate: CharactersProviderDelegate) {
        self.delegate = delegate
    }

    fileprivate func getParams() -> [String : String] {

        let params = ["limit" : "\(pageSize)", "offset": "\(page * pageSize)"]
        return params
    }

    func getItems() -> [Character] {
        return CharactersDatabase.shared.getItems()
    }

    func doSearch(name: String) {
        let request = Request(path: self.pathForResource, params: ["name": name])
        Requester<Character>.get(request) { result in
            switch result {
            case .sucess(let value):
                guard let value = value as? PayloadRequest<Character> else { return }
                self.delegate?.searchResult(data: value.data.results, error: nil)
            case .error(let error):
                self.delegate?.searchResult(data: nil, error: error)
            }
        }
    }

    func getFavorite(id: Int) {
        let request = Request(path: "\(self.pathForResource)/\(id)", params: [:])
        Requester<Character>.get(request) { result in
            switch result {
            case .sucess(let value):
                guard let value = value as? PayloadRequest<Character> else { return }
                self.delegate?.finishFavoriteCharacter(data: value.data.results.first, error: nil)
            case .error(let error):
                self.delegate?.finishFavoriteCharacter(data: nil, error: error)
            }
        }
    }

    func getPage() {
        guard running == false else { return }
        running = true
        guard (self.total / pageSize) <= page else { return }

        let request = Request(path: self.pathForResource, params: getParams())
        Requester<MarvelApp.Character>.get(request) { result in
            switch result {
            case .sucess(let value):
                guard let value = value as? PayloadRequest<MarvelApp.Character> else { self.delegate?.finishLoadPage(error: nil) ; return }
                CharactersDatabase.shared.addItems(characters: value.data.results)
                self.total = value.data.count
                self.delegate?.finishLoadPage(error: nil)
                self.page += 1
            case .error(let error):
                self.delegate?.finishLoadPage(error: error)
            }
            self.running = false
        }
    }

    func getFavoriteID() -> Int? {
        return CharactersDatabase.shared.favoriteID
    }
    func saveFavoriteID(id: Int) {
        CharactersDatabase.shared.favoriteID = id
    }

    func cleanFavoriteID() {
        CharactersDatabase.shared.favoriteID = nil
    }
}
