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
}

class CharactersViewModel: CharactersViewModelProtocol,CharactersProviderDelegate {

    let provider: CharactersProvider
    let feedback: CharactersViewModelFeedback

    init(feedback: CharactersViewModelFeedback ) {
        self.feedback = feedback
        self.provider = CharactersProvider(delegate: self)
    }
    func loadData() {

    }

}

extension CharactersViewModel {
    func finishLoadPage(error: Error?) {
        guard error == nil else { return }
        feedback.reloadData()
    }

    func searchResult(data: [Character]?, error: Error?) {
        <#code#>
    }

    func finishFavoriteCharacter(data: Character?, error: Error?) {
        <#code#>
    }
}
