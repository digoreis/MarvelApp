//
//  CharactersViewModel.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 05/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

protocol CharactersViewModelFeedback {
    func reloadData()
    func reloadFavorite()
}

protocol CharactersViewModelProtocol {
    func loadFavorite()
    func loadData()
    func countData() -> Int
    func character(index: Int) -> Character?
    var searchString : String? { get set }
    var favoriteCharacter : Character? { get set }
}

final class CharactersViewModel: CharactersViewModelProtocol,CharactersProviderDelegate {

    fileprivate var provider: CharactersProvider?
    fileprivate let feedback: CharactersViewModelFeedback?

    fileprivate var searchTempResult : [Character]?

    var favoriteCharacter : Character? = nil {
        didSet {
            if let fav = favoriteCharacter {
                self.provider?.saveFavoriteID(id: fav.id)
            }
            feedback?.reloadFavorite()
        }
    }
    
    var searchString : String? {
        didSet {
            if let searchString = searchString, !searchString.isEmpty {
                provider?.doSearch(name: searchString)
            } else {
                searchTempResult = nil
                feedback?.reloadData()
            }
        }
    }

    init(feedback: CharactersViewModelFeedback? ) {
        self.feedback = feedback
        configure()
    }

    fileprivate func configure() {
        self.provider = CharactersProvider(delegate: self)
    }

    func loadData() {
        self.provider?.getPage()
    }



    func countData() -> Int {
        if let temp = searchTempResult {
            return temp.count
        }
        return CharactersDatabase.shared.count()
    }

    func character(index: Int) -> Character? {
        if let temp = searchTempResult {
            guard index < temp.count else { return nil}
            return temp[index]
        }
        return CharactersDatabase.shared.get(index: index)
    }

    func loadFavorite() {
        guard let id = self.provider?.getFavoriteID() else { return }
        self.provider?.getFavorite(id: id)
    }

}

extension CharactersViewModel {
    func finishLoadPage(error: Error?) {
        guard error == nil else { return }
        feedback?.reloadData()
    }

    func searchResult(data: [Character]?, error: Error?) {
        guard error == nil else { return }
        self.searchTempResult = data
        feedback?.reloadData()
    }

    func finishFavoriteCharacter(data: Character?, error: Error?) {
        guard error == nil else { return }
        self.favoriteCharacter = data
    }
}
