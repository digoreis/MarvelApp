//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 27/02/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController {

    @IBOutlet private var collection: UICollectionView!
    @IBOutlet private var load: UIActivityIndicatorView!

    fileprivate var viewModel: CharactersViewModelProtocol?
    fileprivate var originFrame: CGRect?
    fileprivate var originImage: UIImage?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CharactersViewModel(feedback: self)
        self.viewModel?.loadData()
        self.navigationController?.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detailCharacterSegue" else { return }
        guard let index = sender as? Int else { return }
        guard let destination = segue.destination as? CharacterDetailViewController else { return }
        guard let item = self.viewModel?.character(index: index) else { return }
        destination.viewModel = CharactersDetailViewModel(item: item)
    }
}

extension CharactersViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let frame = self.originFrame else { return nil }
        guard let image = self.originImage else { return nil }

        switch operation {
        case .push:
            return CharacterAnimation(originFrame: frame, image: image, isShow: true)
        default:
            return CharacterAnimation(originFrame: frame, image: image)
        }
    }
}

// MARK: - Methods about Feedback of CharactersViewModelProtocol
extension CharactersViewController: CharactersViewModelFeedback {
    func reloadData() {
        DispatchQueue.main.async {
            self.collection.reloadData()
        }
    }
}

// MARK: - Collection DataSource Methods using ViewModel
extension CharactersViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = self.viewModel?.countData() ?? 0
        if total > 0 {
            load.stopAnimating()
        }
        return total
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharactersCollectionCell.self), for: indexPath)
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

// MARK: - Collection Delegate using ViewModel
extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theAttributes = collectionView.layoutAttributesForItem(at: indexPath)
        if let cell = collectionView.cellForItem(at: indexPath) as?  CharactersCollectionCell,
            let frame = theAttributes?.frame {
            self.originImage = cell.image()
            self.originFrame = collectionView.convert(frame, to: collectionView.superview)
        }

        self.performSegue(withIdentifier: "detailCharacterSegue", sender: indexPath.row)
    }
}

