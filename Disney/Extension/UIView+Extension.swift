//
//  UIView+Extension.swift
//  Disney
//
//  Created by Matthew cai on 12/14/19.
//  Copyright © 2019 Matthew cai. All rights reserved.
//

import UIKit

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView  {
    static var nibName: String {
        return String(describing: self)
    }
}

protocol ReusableViewIdentifable {
    static var defaultReuseIdentifier: String { get}
}

extension ReusableViewIdentifable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
