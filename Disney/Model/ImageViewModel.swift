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
    
    var filteredURL: String? {
        var component = URLComponents(string: self.urlString)
        let host = component?.host
        let domain = host?.components(separatedBy: ".")
        let characterSet = NSCharacterSet.decimalDigits.inverted
        let filteredDomain = domain?.filter { $0.rangeOfCharacter(from: characterSet) != nil }
        let filteredHost = filteredDomain?.joined(separator: ".")
        component?.host = filteredHost
        return component?.url?.absoluteString
    }
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
