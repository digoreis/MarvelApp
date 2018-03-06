//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 27/02/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import UIKit

class CharactersCollectionCell: UICollectionViewCell {
    @IBOutlet let imageView: UIImageView
    @IBOutlet let name: UILabel
}
class CharactersViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet let collection: UICollectionView
    @IBOutlet let load: UIActivityIndicatorView

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

