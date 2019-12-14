//
//  ImageCollectionViewCell.swift
//  Disney
//
//  Created by Matthew cai on 12/14/19.
//  Copyright © 2019 Matthew cai. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView?
    
    var viewModel: ImageViewModel? {
        didSet {
            updateImage()
        }
    }
    
    func populate(viewModel: ImageViewModel) {
        self.viewModel = viewModel
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
    
    func updateImage() {
        let downloader = ImageDownloader(url: self.viewModel?.urlString)
        downloader.download { (image) in
            self.imageView?.image = image
        }
    }
    
}

extension ImageCollectionViewCell: ReusableViewIdentifable { }
