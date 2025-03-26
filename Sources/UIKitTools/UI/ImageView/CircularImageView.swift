//
//
//
// Created by: Patrik Drab on 09/02/2025
// Copyright (c) 2025 UIKitPro 
//
//         

import UIKit

public class CircularImageView: UIImageView {
    public init(width: CGFloat, image: UIImage? = nil) {
        super.init(image: image)
        
        self.contentMode = .scaleAspectFill
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
            self.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        }
        
        self.clipsToBounds = true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
