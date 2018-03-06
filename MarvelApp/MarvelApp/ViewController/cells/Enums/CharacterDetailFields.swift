//
//  CharacterDetailFields.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 06/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import UIKit

enum CharacterDetailFields {
    case label(String,String)
    case text(String,String)
}

extension CharacterDetailFields {
    public func cellID() -> String {
        switch self {
        case .label:
            return String(describing: DetailLabelTableViewCell.self)
        case .text:
            return String(describing: DetailTextTableViewCell.self)
        }
    }

    public func populateCell(_ cell: UITableViewCell?) {
        guard let cell = cell else { return }
        switch self {
        case .label(let title,let text):
            guard let labelCell = cell as? DetailLabelTableViewCell else { return }
            labelCell.setLabel(label: title, text: text)
            break
        case .text(let title,let text):
            guard let labelCell = cell as? DetailTextTableViewCell else { return }
            labelCell.setLabel(label: title, text: text)
            break
        }
    }
}
