//
//  DetailLabelTableViewCell.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 06/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import UIKit

final class DetailLabelTableViewCell: UITableViewCell {

    @IBOutlet fileprivate var lblTitle: UILabel!
    @IBOutlet fileprivate var lblText: UILabel!

    func setLabel(label: String,text: String) {
        self.lblTitle.text = label
        self.lblText.text = text
    }

}
