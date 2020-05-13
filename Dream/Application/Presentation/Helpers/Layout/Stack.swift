//
//  Stack.swift
//  Мечта.ру
//

import UIKit

// MARK: - Stack

extension Array where Element: UIView {

    /// Place current views in the given view as vertical stack
    ///
    /// - Parameters:
    ///   - view: Target view
    ///   - spacing: Current views' spacing
    func verticalStack(in view: UIView, spacing: CGFloat = 0) {

        forEach {
            view.addSubview($0)
            $0.prepareForAutolayout()
            $0.left.connect(to: view.left)
            $0.right.connect(to: view.right)
        }

        first?.top.connect(to: view.top, withOffset: spacing)
        last?.bottom.connect(to: view.bottom, withOffset: -spacing)

        guard count > 1 else {
            return
        }

        for index in 0..<count - 1 {
            self[index].bottom.connect(to: self[index + 1].top, withOffset: -spacing)
            self[index].height.equal(to: self[index + 1].height)
        }
    }

    /// Place current views in the given view as horizontal stack
    ///
    /// - Parameters:
    ///   - view: Target view
    ///   - spacing: Current views' spacing
    func horizontalStack(in view: UIView, spacing: CGFloat = 0) {

        forEach {
            view.addSubview($0)
            $0.prepareForAutolayout()
            $0.top.connect(to: view.top)
            $0.bottom.connect(to: view.bottom)
        }

        first?.left.connect(to: view.left, withOffset: spacing)
        last?.right.connect(to: view.right, withOffset: -spacing)

        guard count > 1 else {
            return
        }

        for index in 0..<count - 1 {
            self[index].right.connect(to: self[index + 1].left, withOffset: -spacing)
            self[index].width.equal(to: self[index + 1].width)
        }
    }
}
