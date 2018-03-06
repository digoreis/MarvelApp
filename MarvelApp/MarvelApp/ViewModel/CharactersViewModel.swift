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
}

protocol CharactersViewModelProtocol {
    func loadData()
    func countData() -> Int
    func character(index: Int) -> Character?
}

class CharactersViewModel: CharactersViewModelProtocol,CharactersProviderDelegate {

    var provider: CharactersProvider?
    let feedback: CharactersViewModelFeedback?


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
        return CharactersDatabase.shared.count()
    }

    func character(index: Int) -> Character? {
        return CharactersDatabase.shared.get(index: index)
    }

}

extension CharactersViewModel {
    func finishLoadPage(error: Error?) {
        guard error == nil else { return }
        feedback?.reloadData()
    }

    func searchResult(data: [Character]?, error: Error?) {

    }

    func finishFavoriteCharacter(data: Character?, error: Error?) {
        
    }
}
