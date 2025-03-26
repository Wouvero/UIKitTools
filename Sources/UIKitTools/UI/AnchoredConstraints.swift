//
//
//
// Created by: Patrik Drab on 10/02/2025
// Copyright (c) 2025 UIKitPro 
//
//         

import UIKit

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}


public struct AnchoredEdges: OptionSet, Sendable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    // Regular edges
    public static let top = AnchoredEdges(rawValue: 1 << 0)
    public static let bottom = AnchoredEdges(rawValue: 1 << 1)
    public static let leading = AnchoredEdges(rawValue: 1 << 2)
    public static let trailing = AnchoredEdges(rawValue: 1 << 3)
    
    // Safe area edges
    public static let topSafeArea = AnchoredEdges(rawValue: 1 << 4)
    public static let bottomSafeArea = AnchoredEdges(rawValue: 1 << 5)
    public static let leadingSafeArea = AnchoredEdges(rawValue: 1 << 6)
    public static let trailingSafeArea = AnchoredEdges(rawValue: 1 << 7)
    
    // Convenience sets
    public static let all: AnchoredEdges = [.top, .bottom, .leading, .trailing]
    public static let allSafeArea: AnchoredEdges = [.topSafeArea, .bottomSafeArea, .leadingSafeArea, .trailingSafeArea]
    
    // Computed properties for direct access
    public var top: Bool { return self.contains(.top) }
    public var bottom: Bool { return self.contains(.bottom) }
    public var leading: Bool { return self.contains(.leading) }
    public var trailing: Bool { return self.contains(.trailing) }
    public var topSafeArea: Bool { return self.contains(.topSafeArea) }
    public var bottomSafeArea: Bool { return self.contains(.bottomSafeArea) }
    public var leadingSafeArea: Bool { return self.contains(.leadingSafeArea) }
    public var trailingSafeArea: Bool { return self.contains(.trailingSafeArea) }
}



@available(iOS 11.0, tvOS 11.0, *)
public enum Anchor {
    case top(_ top: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case leading(_ leading: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case bottom(_ bottom: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case trailing(_ trailing: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case height(_ constant: CGFloat)
    case width(_ constant: CGFloat)
}

extension UIView {
    
    @discardableResult
    public func anchor(_ anchors: Anchor...) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchors.forEach { anchor in
            switch anchor {
            case .top(let anchor, let constant):
                anchoredConstraints.top = topAnchor.constraint(equalTo: anchor, constant: constant)
            case .leading(let anchor, let constant):
                anchoredConstraints.leading = leadingAnchor.constraint(equalTo: anchor, constant: constant)
            case .bottom(let anchor, let constant):
                anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: anchor, constant: -constant)
            case .trailing(let anchor, let constant):
                anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: anchor, constant: -constant)
            case .height(let constant):
                if constant > 0 {
                    anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
                }
            case .width(let constant):
                if constant > 0 {
                    anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
                }
            }
        }
        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing,
         anchoredConstraints.width,
         anchoredConstraints.height].forEach {
            $0?.isActive = true
        }
        return anchoredConstraints
    }
    
    
    @discardableResult
    public func anchor(
        top: NSLayoutYAxisAnchor?,
        leading: NSLayoutXAxisAnchor?,
        bottom: NSLayoutYAxisAnchor?,
        trailing: NSLayoutXAxisAnchor?,
        padding: UIEdgeInsets = .zero,
        size: CGSize = .zero
    ) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [
            anchoredConstraints.top,
            anchoredConstraints.leading,
            anchoredConstraints.bottom,
            anchoredConstraints.trailing,
            anchoredConstraints.width,
            anchoredConstraints.height
        ].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
}
