//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 06/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import UIKit

class CharactersCollectionCell: UICollectionViewCell {
    @IBOutlet fileprivate var imageView: UIImageViewAsync!
    @IBOutlet fileprivate var name: UILabel!
    fileprivate var item: Character?

    fileprivate func clean() {
        self.name.text = ""
        self.imageView.image = UIImage(named: "placeholder")
    }

    @IBAction func favoriteButtonTap(_ button: UIButton) {
        button.isSelected = !button.isSelected
    }

    public func populate(item: Character) {
        self.item = item
        self.name.text = item.name
        if let path = item.thumbnail?.path, let ext = item.thumbnail?.extension {
            self.imageView.imageFromServerURL(urlString: "\(path).\(ext)")
        }
    }

    public func image() -> UIImage? {
        return imageView.image
    }
}
