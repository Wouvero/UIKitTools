//
//
//
// Created by: Patrik Drab on 29/05/2025
// Copyright (c) 2025 UIKitTools
//
//

import UIKit

public class IconImageView: UIImageView {
    // MARK: - Properties
    private var pointSize: CGFloat
    private var weight: UIImage.SymbolWeight
    private var scale: UIImage.SymbolScale
    
    private var systemName: String
    private var color: UIColor
    
    // MARK: - Initializer
    init(
        systemName: String,
        color: UIColor,
        pointSize: CGFloat = 20,
        weight: UIImage.SymbolWeight = .regular,
        scale: UIImage.SymbolScale = .medium
    ) {
        self.systemName = systemName
        self.color = color
        self.pointSize = pointSize
        self.weight = weight
        self.scale = scale
        
        let imageConfiguration = UIImage.SymbolConfiguration(
            pointSize: pointSize,
            weight: weight,
            scale: scale
        )
        
        let imageIcon = UIImage(
            systemName: systemName,
            withConfiguration: imageConfiguration
        )?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        super.init(image: imageIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public API
extension IconImageView {
    public func setIcon(systemName: String) {
        self.systemName = systemName
        updateIcon()
    }
    
    public func setColor(_ color: UIColor) {
        self.color = color
        updateIcon()
    }
    
    public func setSize(_ pointSize: CGFloat) {
        self.pointSize = pointSize
        updateIcon()
    }
    
    public func setWeight(_ weight: UIImage.SymbolWeight) {
        self.weight = weight
        updateIcon()
    }
    
    public func setScale(_ scale: UIImage.SymbolScale) {
        self.scale = scale
        updateIcon()
    }
    
    public func setConfig(pointSize: CGFloat, weight: UIImage.SymbolWeight, scale: UIImage.SymbolScale) {
        self.pointSize = pointSize
        self.weight = weight
        self.scale = scale
        updateIcon()
    }
    
    private func updateIcon() {
        let imageConfiguration = UIImage.SymbolConfiguration(
            pointSize: pointSize,
            weight: weight,
            scale: scale
        )
        
        let imageIcon = UIImage(
            systemName: systemName,
            withConfiguration: imageConfiguration
        )?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        self.image = imageIcon
    }
}


