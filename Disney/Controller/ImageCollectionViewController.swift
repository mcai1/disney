//
//  ImageCollectionViewController.swift
//  Disney
//
//  Created by Matthew cai on 12/14/19.
//  Copyright © 2019 Matthew cai. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController {
    

    var service = ImageService()
    
    var viewModel: ImageSetViewModel? {
        didSet {
            let contentOffSet = self.collectionView.contentOffset
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
            self.collectionView.setContentOffset(contentOffSet, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        update()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        self.collectionView.addGestureRecognizer(longPress)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // assume its one section
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.viewModel?.imageViewModels?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = self.viewModel?.imageViewModels?[indexPath.row]
        let cell = viewModel?.cellInstance(collectionView, indexPath: indexPath)
    
        return cell ?? UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = self.viewModel?.imageViewModels?.count ?? 0
        if (indexPath.row == lastItem - 1 ) {
            update()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = self.viewModel?.imageViewModels?[indexPath.row]
        let viewController = FullViewImageViewController()
        viewController.viewModel = viewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func longPress(gesture : UILongPressGestureRecognizer) {
        if gesture.state != .ended {
             return
         }
         let path = gesture.location(in: self.collectionView)

         if let indexPath = self.collectionView.indexPathForItem(at: path) {
             let cell = self.collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
            UIPasteboard.general.image = cell?.imageView?.image;
         }
    }
    
}

extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let paddedWidth = collectionView.bounds.width - padding
        let width = paddedWidth / 4
        return CGSize(width: width, height: width)
    }

}

extension ImageCollectionViewController: UIGestureRecognizerDelegate {
    
}

extension ImageCollectionViewController {
    
    func update() {
        self.service.fetch(count: self.viewModel?.count ?? 50) { [weak self] (image, error) in
            // do something with error
            DispatchQueue.main.async {
                let nextCount = self?.viewModel?.nextCount ?? 50
                self?.viewModel = ImageSetViewModel(count: nextCount, imageSet: image)
            }
        }
    }
    
}
