//
//  UIFavoriteCharacter.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 06/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import UIKit

class UIFavoriteCharacter: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnOpen: UIButton!
    @IBOutlet weak var favoriteImage: UIImageViewAsync!

    fileprivate var item : Character? {
        didSet {
            if let i = item {
                lblName.text = i.name
                if let path = item?.thumbnail?.path, let ext =  item?.thumbnail?.extension {
                    favoriteImage.imageFromServerURL(urlString: "\(path).\(ext)")
                }
                favoriteImage.isHidden = false
                if callback != nil {
                    btnOpen.isHidden = false
                }
            }
        }
    }
    fileprivate var callback : ((Character) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInt()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInt()
    }

    public func configureFavorite(_ character: Character, callback: @escaping (Character) -> Void) {
        self.callback = callback
        self.item = character
    }

    @IBAction func open(_ button: UIButton) {
        if let i = self.item, let c = self.callback {
            c(i)
        }
    }

    func reset() {
        lblName.text = "Any favorite character selected."
        favoriteImage.isHidden = true
        btnOpen.isHidden = true
    }

    fileprivate func customInt() {
        Bundle.main.loadNibNamed(String(describing: UIFavoriteCharacter.self), owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }

}
