//
//
//
// Created by: Patrik Drab on 02/03/2025
// Copyright (c) 2025 UIKitPro
//
//

import UIKit



public class IconImageView: UIImageView {
    public static let defaultIconConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)
    // MARK: - Properties
    private var currentConfig: UIImage.SymbolConfiguration
    private var systemName: String
    private var color: UIColor
    
    // MARK: - Initializer
    public init(systemName: String,
                config: UIImage.SymbolConfiguration = IconImageView.defaultIconConfiguration,
                tintColor: UIColor = UIColor.black) {
        self.currentConfig = config
        self.systemName = systemName
        self.color = tintColor
        
        let imageIcon = UIImage(systemName: systemName, withConfiguration: config)?
            .withTintColor(color, renderingMode: .alwaysOriginal)
        
        super.init(image: imageIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    public func setSize(pointSize: CGFloat, weight: UIImage.SymbolWeight = .regular, scale: UIImage.SymbolScale = .medium) {
        let newConfig = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        self.currentConfig = newConfig
        updateImage()
    }
    
    /// Updates the tint color of the icon.
    public func setTintColor(_ color: UIColor) {
        self.tintColor = color
        updateImage()
    }
    
    /// Change icon with configuration
    public func setIcon(systemName: String, config: UIImage.SymbolConfiguration = IconImageView.defaultIconConfiguration) {
        self.systemName = systemName
        self.currentConfig = config
        updateImage()
    }
    
    
    // MARK: - Private Methods
    private func updateImage() {
        let imageIcon = UIImage(systemName: systemName, withConfiguration: currentConfig)?
            .withTintColor(tintColor, renderingMode: .alwaysOriginal)
        self.image = imageIcon
    }
}
