//
//  ImageSetViewModel.swift
//  Disney
//
//  Created by Matthew cai on 12/14/19.
//  Copyright © 2019 Matthew cai. All rights reserved.
//

import UIKit

struct ImageSetViewModel {
    
    let count: Int
    let imageSet: ImageSet?
    
    private let countPerPage = 50
    
    var imageViewModels: [ImageViewModel]? {
        return self.imageSet?.pugs.map { ImageViewModel(urlString: $0) }
    }
    
    var nextCount: Int {
        return count + countPerPage
    }
}
