//
//  ImageViewModel.swift
//  Disney
//
//  Created by Matthew cai on 12/14/19.
//  Copyright © 2019 Matthew cai. All rights reserved.
//

import UIKit

struct ImageViewModel {
    let urlString: String
    
}

extension ImageViewModel: CollectionViewCellBuildable {
    func cellInstance(_ collectionView: UICollectionviewDequeueReusable, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.defaultReuseIdentifier,
                                                      for: indexPath)
        if let cell = cell as? ImageCollectionViewCell {
            cell.populate(viewModel: self)
        }
        return cell
    }
}
