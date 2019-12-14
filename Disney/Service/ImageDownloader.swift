//
//  ImageDownloader.swift
//  Disney
//
//  Created by Matthew cai on 12/14/19.
//  Copyright © 2019 Matthew cai. All rights reserved.
//

import UIKit

class ImageDownloader: NSObject, URLSessionDelegate {
    
    var url: String?

    init(url: String?) {
        self.url = url
    }

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
    }()

    func download(completionHandler: @escaping (UIImage?) -> Void) {
        guard let url = self.url, let imageURL = URL(string: url) else {
            return
        }
        self.session.dataTask(with: imageURL) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        completionHandler(image)
                        return
                    }
                }
            }
        }.resume()
    }

}
