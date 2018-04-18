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
    @IBOutlet fileprivate var favoriteBtn: UIButton!
    fileprivate var item: Character?
    fileprivate var viewModel: CharactersViewModelProtocol?

    fileprivate func clean() {
        self.name.text = ""
        self.imageView.image = UIImage(named: "placeholder")
    }

    @IBAction func favoriteButtonTap(_ button: UIButton) {
        button.isSelected = !button.isSelected
        self.viewModel?.favoriteCharacter = (button.isSelected) ? self.item : nil

    }

    public func cleanFavorite() {
        favoriteBtn.isSelected = false
    }
    public func getID() -> Int {
        return item?.id ?? 0
    }

    public func setImage(item: Character) {
        if let path = item.thumbnail?.path, let ext = item.thumbnail?.extension {
            self.imageView.image = #imageLiteral(resourceName: "placeholder")
            self.imageView.imageFromServerURL(urlString: "\(path).\(ext)")
        }
    }

    public func populate(item: Character, viewModel: CharactersViewModelProtocol? = nil, favoriteID : Int = 0) {
        self.item = item
        self.viewModel = viewModel
        self.name.text = item.name
        guard let idFav = self.viewModel?.favoriteCharacter?.id else { favoriteBtn.isSelected = false ; return}
        favoriteBtn.isSelected = (item.id == idFav)
    }

    public func cancelDownload() {
        self.imageView.cancelImageDownload()
    }
    public func image() -> UIImage? {
        return imageView.image
    }
}
