//
//  UITextView.swift
//  Мечта.ру
//

import Foundation

// MARK: - UITextView

extension UITextView {
    
    static func contentHeight(for text: String, font: UIFont, textInsets: UIEdgeInsets, width: CGFloat = UIScreen.main.bounds.width) -> CGFloat {
        let textView = UITextView()
        textView.font = font
        textView.text = text
        textView.textContainerInset = textInsets
        let fixedWidth = width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        return newFrame.height
    }
    
    func contentHeight(insetsMode: Bool) -> CGFloat {
        let fixedWidth = frame.size.width - (insetsMode ? (textContainerInset.left + textContainerInset.right) : 0)
        let newSize = sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
        var newFrame = frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        return newFrame.height + (insetsMode ? (textContainerInset.top + textContainerInset.bottom) : 0)
    }
}
