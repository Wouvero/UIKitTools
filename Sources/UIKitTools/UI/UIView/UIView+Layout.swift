//
//
//
// Created by: Patrik Drab on 08/02/2025
// Copyright (c) 2025 UIKitPro
//
//

import UIKit

@available(iOS 11.0, tvOS 11.0, *)
extension UIView {
    
    
    @discardableResult
    public func pinInSuperview(edges: UIRectEdge = .all, padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        let topAnchor: NSLayoutYAxisAnchor? = edges.contains(.top) ? superview?.topAnchor : nil
        let leadingAnchor: NSLayoutXAxisAnchor? = edges.contains(.left) ? superview?.leadingAnchor : nil
        let bottomAnchor: NSLayoutYAxisAnchor? = edges.contains(.bottom) ? superview?.bottomAnchor : nil
        let trailingAnchor: NSLayoutXAxisAnchor? = edges.contains(.right) ? superview?.trailingAnchor : nil
        
        return anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: padding
        )
    }
    
    
    
    @discardableResult
    public func pinToSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
              let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
              let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
              let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else {
            return AnchoredConstraints()
        }
        
        return anchor(
            top: superviewTopAnchor,
            leading: superviewLeadingAnchor,
            bottom: superviewBottomAnchor,
            trailing: superviewTrailingAnchor,
            padding: padding
        )
    }
    

    public func pinToSuperview(edges: AnchoredEdges = .all, padding: UIEdgeInsets = .zero) {
        
        guard let superview = superview else { return }
        
        guard !(edges.top && edges.topSafeArea) else {
            print("Error: Cannot specify both top and topSafeArea.")
            return
        }
        guard !(edges.bottom && edges.bottomSafeArea) else {
            print("Error: Cannot specify both bottom and bottomSafeArea.")
            return
        }
        guard !(edges.leading && edges.leadingSafeArea) else {
            print("Error: Cannot specify both leading and leadingSafeArea.")
            return
        }
        guard !(edges.trailing && edges.trailingSafeArea) else {
            print("Error: Cannot specify both trailing and trailingSafeArea.")
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // Top anchor
        if edges.top || edges.topSafeArea {
            let anchor = edges.top ? superview.topAnchor : superview.safeAreaLayoutGuide.topAnchor
            topAnchor.constraint(equalTo: anchor, constant: padding.top).isActive = true
        }
        
        // Bottom anchor
        if edges.bottom || edges.bottomSafeArea {
            let anchor = edges.bottom ? superview.bottomAnchor : superview.safeAreaLayoutGuide.bottomAnchor
            bottomAnchor.constraint(equalTo: anchor, constant: -padding.bottom).isActive = true
        }
        
        // Leading anchor
        if edges.leading || edges.leadingSafeArea {
            let anchor = edges.leading ? superview.leadingAnchor : superview.safeAreaLayoutGuide.leadingAnchor
            leadingAnchor.constraint(equalTo: anchor, constant: padding.left).isActive = true
        }
        
        // Trailing anchor
        if edges.trailing || edges.trailingSafeArea {
            let anchor = edges.trailing ? superview.trailingAnchor : superview.safeAreaLayoutGuide.trailingAnchor
            trailingAnchor.constraint(equalTo: anchor, constant: -padding.right).isActive = true
        }
    }
    
    
    @discardableResult
    public func pinInSuperviewWithLayoutMargins(edges: UIRectEdge = .all, padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        let topAnchor: NSLayoutYAxisAnchor? = edges.contains(.top) ? superview?.layoutMarginsGuide.topAnchor : nil
        let leadingAnchor: NSLayoutXAxisAnchor? = edges.contains(.left) ? superview?.layoutMarginsGuide.leadingAnchor : nil
        let bottomAnchor: NSLayoutYAxisAnchor? = edges.contains(.bottom) ? superview?.layoutMarginsGuide.bottomAnchor : nil
        let trailingAnchor: NSLayoutXAxisAnchor? = edges.contains(.right) ? superview?.layoutMarginsGuide.trailingAnchor : nil
        
        return anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: padding
        )
    }
    
    
    public func centerInSuperview(size: CGSize = .zero, offset: CGPoint = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor{
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor, constant: offset.x).isActive = true
        }
        if let superviewCenterYAnchor = superview?.centerYAnchor{
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor, constant: offset.y).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    public func centerXTo(_ anchor: NSLayoutXAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    public func centerYTo(_ anchor: NSLayoutYAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    
    
    public func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}


extension UIView {
    
    public func alignTop(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding).isActive = true
        }
    }
    
    public func alignBottom(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding).isActive = true
        }
    }
    
    public func alignLeft(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewLeftAnchor = superview?.leftAnchor {
            leftAnchor.constraint(equalTo: superviewLeftAnchor, constant: padding).isActive = true
        }
    }
    
    public func alignRight(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewRightAnchor = superview?.rightAnchor {
            rightAnchor.constraint(equalTo: superviewRightAnchor, constant: padding).isActive = true
        }
    }
    
    public func alignLeading(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding).isActive = true
        }
    }
    
    public func alignTrailing(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: padding).isActive = true
        }
    }
    
    public func alignCenterX(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor, constant: padding).isActive = true
        }
    }
    
    public func alignCenterY(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor, constant: padding).isActive = true
        }
    }
    
    
    
    public func topLeading(offset: CGPoint = .zero) {
        self.alignTop(padding: offset.y)
        self.alignLeft(padding: offset.x)
    }
    
    public func top(offset: CGPoint = .zero) {
        self.alignTop(padding: offset.y)
        self.alignCenterX(padding: offset.x)
    }
    
    public func topTrailing(offset: CGPoint = .zero) {
        self.alignTop(padding: offset.y)
        self.alignTrailing(padding: offset.x)
    }
    
    public func leading(offset: CGPoint = .zero) {
        self.alignCenterY(padding: offset.y)
        self.alignLeading(padding: offset.x)
    }
    
    public func center(offset: CGPoint = .zero) {
        self.alignCenterX(padding: offset.x)
        self.alignCenterY(padding: offset.y)
    }
    
    public func trailing(offset: CGPoint = .zero) {
        self.alignCenterY(padding: offset.y)
        self.alignTrailing(padding: offset.x)
    }
    
    public func bottomLeading(offset: CGPoint = .zero) {
        self.alignBottom(padding: offset.y)
        self.alignLeading(padding: offset.x)
    }
    
    public func bottom(offset: CGPoint = .zero) {
        self.alignBottom(padding: offset.y)
        self.alignCenterX(padding: offset.x)
    }
    
    public func bottomTrailing(offset: CGPoint = .zero) {
        self.alignBottom(padding: offset.y)
        self.alignTrailing(padding: offset.x)
    }
}

extension UIView {
    @discardableResult
    public func withPadding(_ padding: UIEdgeInsets) -> UIView {
        if let stackView = self as? UIStackView {
            stackView.isLayoutMarginsRelativeArrangement = true
        }
        layoutMargins = padding
        return self
    }
    
    @discardableResult
    public func paddingLeft(_ left: CGFloat) -> UIView {
        if let stackView = self as? UIStackView {
            stackView.isLayoutMarginsRelativeArrangement = true
        }
        layoutMargins.left = left
        return self
    }
    
    @discardableResult
    public func paddingTop(_ top: CGFloat) -> UIView {
        if let stackView = self as? UIStackView {
            stackView.isLayoutMarginsRelativeArrangement = true
        }
        layoutMargins.top = top
        return self
    }
    
    @discardableResult
    public func paddingBottom(_ bottom: CGFloat) -> UIView {
        if let stackView = self as? UIStackView {
            stackView.isLayoutMarginsRelativeArrangement = true
        }
        layoutMargins.bottom = bottom
        return self
    }
    
    @discardableResult
    public func paddingRight(_ right: CGFloat) -> UIView {
        if let stackView = self as? UIStackView {
            stackView.isLayoutMarginsRelativeArrangement = true
        }
        layoutMargins.right = right
        return self
    }
}
