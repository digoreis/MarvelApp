//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 06/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var viewModel: CharactersDetailViewModelProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

extension CharacterDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count() ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.item(index: indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellID())
        item.populateCell(cell)
        return cell!
    }
}
