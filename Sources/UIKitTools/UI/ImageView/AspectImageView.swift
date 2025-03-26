//
//
//
// Created by: Patrik Drab on 08/02/2025
// Copyright (c) 2025 UIKitPro 
//
//         

import UIKit


public class ImageView: UIImageView {
    
    private let defaultContentMode: UIView.ContentMode
    
     convenience public init(image: UIImage? = nil, cornerRadius: CGFloat = 0) {
        self.init(image: image)
        self.layer.cornerRadius = cornerRadius
    }
    
    override public init(image: UIImage?) {
        self.defaultContentMode = .scaleAspectFit // Default, can be overridden
        super.init(image: image)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.defaultContentMode = .scaleAspectFit
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.contentMode = defaultContentMode
        self.clipsToBounds = true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
    }
}

public class AspectFitImageView: ImageView {

    override init(image: UIImage?) {
        super.init(image: image)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

public class AspectFillImageView: ImageView {

    override init(image: UIImage?) {
        super.init(image: image)
        setupAspectFill()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAspectFill()
    }
    
    private func setupAspectFill() {
        contentMode = .scaleAspectFill
        clipsToBounds = true // Ensures the image does not overflow the bounds
    }
}
