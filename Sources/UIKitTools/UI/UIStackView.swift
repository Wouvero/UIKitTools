//
//
//
// Created by: Patrik Drab on 18/12/2024
// Copyright (c) 2024 CarExpenseCalculator
//
//

import UIKit

@available(iOS 11.0, tvOS 11.0, *)
extension UIStackView {
    public convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
