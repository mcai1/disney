//
//  ViewController.swift
//  Disney
//
//  Created by Matthew cai on 12/14/19.
//  Copyright © 2019 Matthew cai. All rights reserved.
//

import UIKit

class FullViewImageViewController: UIViewController {
    
    var imageView: UIImageView?
    
    var viewModel: ImageViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        setup()
    }
    
    func setup() {
        setupImageView()
        updateImage()
    }
    
    func setupImageView() {
        let view = UIImageView(image: nil)
        self.imageView = view
        self.view.addSubview(view)
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.imageView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.imageView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func updateImage() {
        let downloader = ImageDownloader(url: self.viewModel?.urlString)
        downloader.download { (image) in
            self.imageView?.image = image
        }
    }

    

}

