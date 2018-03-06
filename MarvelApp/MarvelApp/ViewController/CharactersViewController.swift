//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 27/02/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import UIKit

class CharactersCollectionCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageViewAsync!
    @IBOutlet var name: UILabel!

    fileprivate func clean() {
        self.name.text = ""
        self.imageView.image = UIImage(named: "placeholder")
    }

    func populate(item: Character) {
        self.name.text = item.name
        if let path = item.thumbnail?.path, let ext = item.thumbnail?.extension {
            self.imageView.imageFromServerURL(urlString: "\(path).\(ext)")
        }
    }
}
class CharactersViewController: UIViewController {

    @IBOutlet var collection: UICollectionView!
    @IBOutlet var load: UIActivityIndicatorView!

    var viewModel: CharactersViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CharactersViewModel(feedback: self)
        self.viewModel?.loadData()
    }
}

extension CharactersViewController: CharactersViewModelFeedback {
    func reloadData() {
        DispatchQueue.main.async {
            self.collection.reloadData()
        }
    }
}

extension CharactersViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.countData() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "charCell", for: indexPath)
        nextPage(index: indexPath.row)
        if let charCell = cell as? CharactersCollectionCell,
            let char = self.viewModel?.character(index: indexPath.row) {
            charCell.populate(item: char)
        }
        return cell
    }

    fileprivate func nextPage(index: Int) {
        guard let total =  self.viewModel?.countData() else { return }
        guard index >  Int(Double(total) * 0.8) else { return }
        self.viewModel?.loadData()
    }
}

