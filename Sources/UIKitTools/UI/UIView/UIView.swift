//
//
//
// Created by: Patrik Drab on 18/12/2024
// Copyright (c) 2024 CarExpenseCalculator
//
//

import UIKit


@available(iOS 11.0, tvOS 11.0, *)
extension UIView {
    public convenience init(padding: UIEdgeInsets = .equalSides(0)) {
        self.init(frame: .zero)
        self.withPadding(padding)
    }
    
    public convenience init(color: UIColor?) {
        self.init(frame: .zero)
        self.backgroundColor = color
        self.withPadding(.equalSides(0))
    }
}

@available(iOS 11.0, tvOS 11.0, *)
extension UIView {
    @discardableResult
    public func setShadow<T: UIView>(
        color: UIColor = .black,
        opacity: Float = 0.7,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 20,
        cornerRadius: CGFloat? = nil
    ) -> T? {
        // Set shadow properties
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.cornerRadius = cornerRadius ?? 0
        
        // Ensure shadowPath updates when bounds change
        self.layer.masksToBounds = false // Required to show shadow outside bounds
        let cornerRadius = cornerRadius ?? self.layer.cornerRadius
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layer.shadowPath = UIBezierPath(
                roundedRect: self.bounds,
                cornerRadius: cornerRadius
            ).cgPath
        }
        return self as? T
    }
    
    
    @discardableResult
    public func setBorderAndShadow<T: UIView>(
        borderWidth: CGFloat,
        borderColor: UIColor,
        cornerRadius: CGFloat = 0,
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.7,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        shadowRadius: CGFloat = 4
    ) -> T? {
        // Set border properties
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        
        // Set shadow properties
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        
        // Ensure the shadow is visible
        layer.masksToBounds = false
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layer.shadowPath = UIBezierPath(
                roundedRect: self.bounds,
                cornerRadius: self.layer.cornerRadius
            ).cgPath
        }
        
        return self as? T
    }
    
    
    public func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    
    @discardableResult
    public func setBorder<T: UIView>(width: CGFloat, color: UIColor, cornerRadius: CGFloat = 0) -> T? {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        if cornerRadius != 0 { setCornerRadius(radius: cornerRadius) }
        return self as? T
    }
    
    @discardableResult
    public func setDebugBorder<T: UIView>(width: CGFloat, color: UIColor = UIColor.red) -> T? {
        setBorder(width: width, color: color)
        return self as? T
    }
    
    @discardableResult
    public func setBackground(_ color: UIColor) -> UIView {
        backgroundColor = color
        return self
    }
}

extension UIView {
    
    
    /// 🟠 Rebuild
    
    public func addBorder(for edges: UIRectEdge = .all, in color: UIColor?, width borderWidth: CGFloat) {
        if edges.contains(.top) {
            addTopBorder(in: color, width: borderWidth)
        }
        if edges.contains(.left) {
            addLeftBorder(in: color, width: borderWidth)
        }
        if edges.contains(.right) {
            addRightBorder(in: color, width: borderWidth)
        }
        if edges.contains(.bottom) {
            addBottomBorder(in: color, width: borderWidth)
        }
    }
    
    private func addTopBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        addSubview(border)
    }
    
    private func addBottomBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(border)
    }
    
    private func addLeftBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }
    
    private func addRightBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        addSubview(border)
    }
}


extension CGSize {
    static public func equalEdge(_ edge: CGFloat) -> CGSize {
        return .init(width: edge, height: edge)
    }
}

extension UIEdgeInsets {
    static public func equalSides(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: side, bottom: side, right: side)
    }
    
    static public func vertical(_ side: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: side, bottom: 0, right: side)
    }
    
    
    static public func horizontal(_ side: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: side, left: 0, bottom: side, right: 0)
    }
}
