//
//  UIImageView.swift
//  MarvelApp
//
//  Created by Rodrigo Reis on 06/03/18.
//  Copyright © 2018 Rodrigo Reis. All rights reserved.
//

import UIKit

class UIImageViewAsync: UIImageView {
    fileprivate var task: URLSessionDataTask?

}

extension UIImageViewAsync {
    public func cancelImageDownload() {
        task?.cancel()
    }
    public func imageFromServerURL(urlString: String) {
        task?.cancel()
        guard let url = URL(string: urlString) else { return }
        self.task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard error == nil else { return }
            DispatchQueue.main.async(execute: { () -> Void in
                guard let dataImage = data else { return }
                let image = UIImage(data: dataImage)
                self.image = image
            })

        })
        self.task?.resume()
    }

}
