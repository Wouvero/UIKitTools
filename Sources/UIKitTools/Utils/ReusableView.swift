//
//
//
// Created by: Patrik Drab on 22/02/2025
// Copyright (c) 2025 UIKitPro 
//
//         

import UIKit

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UICollectionViewCell: ReusableView {}
