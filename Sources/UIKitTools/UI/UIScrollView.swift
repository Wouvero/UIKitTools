//
//
//
// Created by: Patrik Drab on 20/12/2024
// Copyright (c) 2024 CarExpenseCalculator 
//
//         
import UIKit

extension UIScrollView {
    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint(x: 0, y: -contentInset.top), animated: animated)
    }
    
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        guard bottomOffset.y >= 0 else { return }
        setContentOffset(bottomOffset, animated: animated)
    }
    
    public func scrollToLeft(animated: Bool = true) {
        setContentOffset(CGPoint(x: -contentInset.left, y: 0), animated: animated)
    }
    
    public func scrollToRight(animated: Bool = true) {
        let rightOffset = CGPoint(x: contentSize.width - bounds.size.width + contentInset.right, y: 0)
        guard rightOffset.x >= 0 else { return }
        setContentOffset(rightOffset, animated: animated)
    }
}

extension UIScrollView {
    public func scrollToView(_ view: UIView, animated: Bool = true) {
        guard let origin = view.superview else { return }
        let targetRect = origin.convert(view.frame, to: self)
        scrollRectToVisible(targetRect, animated: animated)
    }
}

extension UIScrollView {
    public func setContentInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    public func resetContentInsets() {
        contentInset = .zero
    }
}

extension UIScrollView {
    public var isAtTop: Bool {
        return contentOffset.y <= -contentInset.top
    }

    public var isAtBottom: Bool {
        return contentOffset.y >= (contentSize.height - bounds.size.height + contentInset.bottom)
    }

    public var isAtLeft: Bool {
        return contentOffset.x <= -contentInset.left
    }

    public var isAtRight: Bool {
        return contentOffset.x >= (contentSize.width - bounds.size.width + contentInset.right)
    }
}


extension UIScrollView {
    public func stopScrolling() {
        setContentOffset(contentOffset, animated: false)
    }
}


//extension UIScrollView {
//    func adjustForKeyboard() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    
//    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//        let keyboardHeight = keyboardFrame.height
//        contentInset.bottom = keyboardHeight
//        scrollIndicatorInsets.bottom = keyboardHeight
//    }
//    
//    @objc private func keyboardWillHide(_ notification: Notification) {
//        contentInset.bottom = 0
//        scrollIndicatorInsets.bottom = 0
//    }
//    
//    func stopAdjustingForKeyboard() {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//}

extension UIScrollView {
    public func scrollToPage(index: Int, animated: Bool = true) {
        let offsetX = CGFloat(index) * bounds.size.width
        guard offsetX >= 0 && offsetX <= contentSize.width - bounds.size.width else { return }
        setContentOffset(CGPoint(x: offsetX, y: 0), animated: animated)
    }

    public var currentPage: Int {
        return Int((contentOffset.x + bounds.size.width / 2) / bounds.size.width)
    }
}


extension UIScrollView {
    public func enableTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}
