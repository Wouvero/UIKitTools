//
//
//
// Created by: Patrik Drab on 11/02/2025
// Copyright (c) 2025 UIKitPro
//
//

import SwiftUI

public struct ViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    private let builder: () -> ViewController
    
    public init(_ builder: @escaping () -> ViewController) {
        self.builder = builder
    }
    
    public func makeUIViewController(context: Context) -> ViewController {
        return builder()
    }
    
    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // No updates needed
    }
}


public struct ViewPreview<ViewType: UIView>: UIViewRepresentable {
    private let builder: () -> ViewType

    public init(_ builder: @escaping () -> ViewType) {
        self.builder = builder
    }

    public func makeUIView(context: Context) -> ViewType {
        return builder()
    }

    public func updateUIView(_ uiView: ViewType, context: Context) {
        // No updates needed for previews
    }
}
