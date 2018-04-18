//
//  ResourceURIRequest.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 03/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import Foundation

protocol ResourceURIRequestable: Codable, AnyObject {
    var resourceURI: String { get }
    func isLoaded() -> Bool
    func populate(item: Self)
}

extension ResourceURIRequestable {
    public func load(callback: @escaping (Bool) -> Void) {
        guard isLoaded() == false else { callback(true) ; return }
        let request = Request(path: self.resourceURI, params: [:])
        Requester<Self>.get(request) { result in

            switch result {
            case .sucess(let value):
                weak var weakSelf = self
                guard let value = value as? PayloadRequest<Self>,
                      let result = value.data.results.first else { return }
                weakSelf?.populate(item: result)
                callback(true)
            case .error(let error):
                callback(false)
                print(error)
            }
        }
    }
}
