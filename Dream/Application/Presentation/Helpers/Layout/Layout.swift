//
//  Layout.swift
//  Мечта.ру
//

import UIKit

// MARK: - UIView

extension UIView {

    // MARK: - Properties

    /// Width constraint
    var width: DimensionConstraint {
        return DimensionConstraint(constraint: widthAnchor)
    }

    /// Height constraint
    var height: DimensionConstraint {
        return DimensionConstraint(constraint: heightAnchor)
    }

    /// Left constraint
    var left: Constraint<NSLayoutXAxisAnchor> {
        return Constraint(constraint: leadingAnchor)
    }

    /// Right constraint
    var right: Constraint<NSLayoutXAxisAnchor> {
        return Constraint(constraint: trailingAnchor)
    }

    /// Top constraint
    var top: Constraint<NSLayoutYAxisAnchor> {
        return Constraint(constraint: topAnchor)
    }

    /// Bottom constraint
    var bottom: Constraint<NSLayoutYAxisAnchor> {
        return Constraint(constraint: bottomAnchor)
    }

    /// Center on X axis constraint
    var centerX: Constraint<NSLayoutXAxisAnchor> {
        return Constraint(constraint: centerXAnchor)
    }

    /// Center on Y axis constraint
    var centerY: Constraint<NSLayoutYAxisAnchor> {
        return Constraint(constraint: centerYAnchor)
    }

    /// Top left anchor constraint
    var topLeftAngle: ConstraintAngle {
        return ConstraintAngle(first: leadingAnchor, second: topAnchor)
    }

    /// Top right anchor constraint
    var topRightAngle: ConstraintAngle {
        return ConstraintAngle(first: trailingAnchor, second: topAnchor)
    }

    /// Bottom left anchor constraint
    var bottomLeftAngle: ConstraintAngle {
        return ConstraintAngle(first: leadingAnchor, second: bottomAnchor)
    }

    /// Bottom right angle constraint
    var bottomRightAngle: ConstraintAngle {
        return ConstraintAngle(first: trailingAnchor, second: bottomAnchor)
    }

    // MARK: - Useful methods

    /// Prepare view for auto layout
    ///
    /// - Returns: Current view
    @discardableResult func prepareForAutolayout() -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    /// Set view size through width and height
    ///
    /// - Parameters:
    ///   - width: View width
    ///   - height: View height
    /// - Returns: Current view
    @discardableResult func size(width: CGFloat, height: CGFloat) -> UIView {
        self.width.equal(to: width)
        self.height.equal(to: height)
        return self
    }
    
    /// Set view size
    ///
    /// - Parameters:
    ///   - size: View width and height
    /// - Returns: Current view
    @discardableResult func size(_ size: CGFloat) -> UIView {
        return self.size(width: size, height: size)
    }

    /// Set view size as size of another view
    ///
    /// - Parameters:
    ///   - view: View for emulating
    ///   - multiplier: Constraints multiplier
    /// - Returns: Current view
    @discardableResult func size(as view: UIView, multiplier: CGFloat = 1) -> UIView {
        width(equalTo: view.width, multiplier: multiplier)
        height(equalTo: view.height, multiplier: multiplier)
        return self
    }

    /// Set view width
    ///
    /// - Parameter const: width value
    /// - Returns: Current view
    @discardableResult func width(_ const: CGFloat) -> UIView {
        width.equal(to: const)
        return self
    }

    /// Set view height
    ///
    /// - Parameter const: height value
    /// - Returns: Current view
    @discardableResult func height(_ const: CGFloat) -> UIView {
        height.equal(to: const)
        return self
    }
    
    /// Set view height
    ///
    /// - Parameters:
    ///   - const: min height value
    /// - Returns: Current view
    @discardableResult func height(greaterThanOrEqualTo const: CGFloat) -> UIView {
        height.greaterThanOrEqual(to: const)
        return self
    }

    /// Set view width through another constraint
    ///
    /// - Parameters:
    ///   - other: constraint for emulating
    ///   - multiplier: constraint's multiplier
    /// - Returns: Current view
    @discardableResult func width(equalTo other: DimensionConstraint, multiplier: CGFloat = 1) -> UIView {
        width.equal(to: other, multiplier: multiplier)
        return self
    }
    
    /// Set view width through another constraint
    ///
    /// - Parameters:
    ///   - other: constraint for emulating
    ///   - multiplier: constraint's multiplier
    /// - Returns: Current view
    @discardableResult func width(greaterThanOrEqualTo other: DimensionConstraint, multiplier: CGFloat = 1) -> UIView {
        width.greaterThanOrEqual(to: other, multiplier: multiplier)
        return self
    }
    
    /// Set view width through another constraint
    ///
    /// - Parameters:
    ///   - other: constraint for emulating
    ///   - multiplier: constraint's multiplier
    /// - Returns: Current view
    @discardableResult func width(lessThanOrEqualTo other: DimensionConstraint,
                                  multiplier: CGFloat = 1,
                                  constant: CGFloat = 0) -> UIView {
        width.lessThanOrEqual(to: other, multiplier: multiplier, constant: constant)
        return self
    }

    /// Set view height through another constraint
    ///
    /// - Parameters:
    ///   - other: constraint for emulating
    ///   - multiplier: constraint's multiplier
    /// - Returns: Current view
    @discardableResult func height(equalTo other: DimensionConstraint, multiplier: CGFloat = 1) -> UIView {
        height.equal(to: other, multiplier: multiplier)
        return self
    }

    /// Connect current bottom to other bottom
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func bottom(to other: Constraint<NSLayoutYAxisAnchor>) -> UIView {
        bottom.connect(to: other)
        return self
    }

    /// Connect current top to other top
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func top(to other: Constraint<NSLayoutYAxisAnchor>) -> UIView {
        top.connect(to: other)
        return self
    }

    /// Connect current left to other left
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func left(to other: Constraint<NSLayoutXAxisAnchor>) -> UIView {
        left.connect(to: other)
        return self
    }

    /// Connect current right to other right
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func right(to other: Constraint<NSLayoutXAxisAnchor>) -> UIView {
        right.connect(to: other)
        return self
    }
    
    /// Connect current bottom to other bottom
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func bottom(to other: MetaConstraint<NSLayoutYAxisAnchor>) -> UIView {
        bottom.connect(to: other)
        return self
    }
    
    /// Connect current top to other top
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func top(to other: MetaConstraint<NSLayoutYAxisAnchor>) -> UIView {
        top.connect(to: other)
        return self
    }
    
    /// Connect current left to other left
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func left(to other: MetaConstraint<NSLayoutXAxisAnchor>) -> UIView {
        left.connect(to: other)
        return self
    }
    
    /// Set view left through another constraint
    ///
    /// - Parameters:
    ///   - other: Constraint for emulating
    ///   - constant: The constant offset for the constraint
    /// - Returns: Current view
    @discardableResult func left(greaterThanOrEqualTo other: Constraint<NSLayoutXAxisAnchor>,
                                 c constant: CGFloat = 0) -> UIView {
        left.greaterThanOrEqual(to: other, c: constant)
        return self
    }
    
    /// Set view left through another constraint
    ///
    /// - Parameters:
    ///   - other: Constraint for emulating
    ///   - constant: The constant offset for the constraint
    /// - Returns: Current view
    @discardableResult func left(lessThanOrEqualTo other: Constraint<NSLayoutXAxisAnchor>,
                                 c constant: CGFloat = 0) -> UIView {
        left.lessThanOrEqual(to: other, c: constant)
        return self
    }
    
    /// Connect current right to other right
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func right(to other: MetaConstraint<NSLayoutXAxisAnchor>) -> UIView {
        right.connect(to: other)
        return self
    }
    
    /// Set view right through another constraint
    ///
    /// - Parameters:
    ///   - other: Constraint for emulating
    ///   - constant: The constant offset for the constraint
    /// - Returns: Current view
    @discardableResult func right(greaterThanOrEqualTo other: Constraint<NSLayoutXAxisAnchor>,
                                  c constant: CGFloat = 0) -> UIView {
        right.greaterThanOrEqual(to: other, c: constant)
        return self
    }
    
    /// Set view right through another constraint
    ///
    /// - Parameters:
    ///   - other: Constraint for emulating
    ///   - constant: The constant offset for the constraint
    /// - Returns: Current view
    @discardableResult func right(lessThanOrEqualTo other: Constraint<NSLayoutXAxisAnchor>,
                                  c constant: CGFloat = 0) -> UIView {
        right.lessThanOrEqual(to: other, c: constant)
        return self
    }

    /// Connect current centerX to other centerX
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func centerX(to other: Constraint<NSLayoutXAxisAnchor>) -> UIView {
        centerX.connect(to: other)
        return self
    }

    /// Connect current centerY to other centerY
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func centerY(to other: Constraint<NSLayoutYAxisAnchor>) -> UIView {
        centerY.connect(to: other)
        return self
    }
    
    /// Connect current centerX to other centerX
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func centerX(to other: MetaConstraint<NSLayoutXAxisAnchor>) -> UIView {
        centerX.connect(to: other)
        return self
    }
    
    /// Connect current centerY to other centerY
    ///
    /// - Parameter other: constraint for connection
    /// - Returns: Current view
    @discardableResult func centerY(to other: MetaConstraint<NSLayoutYAxisAnchor>) -> UIView {
        centerY.connect(to: other)
        return self
    }

    /// Connect current center to other center
    ///
    /// - Parameter view: View with target center
    /// - Returns: Current view
    @discardableResult func center(in view: UIView) -> UIView {
        centerX.connect(to: view.centerX)
        centerY.connect(to: view.centerY)
        return self
    }

    /// Pin current view to other view with edges instets
    ///
    /// - Parameters:
    ///   - view: View for connection
    ///   - left: left inset
    ///   - right: right inset
    ///   - top: top inset
    ///   - bottom: bottom inset
    /// - Returns: Current view
    @discardableResult func pinEdges(to view: UIView, left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) -> UIView {
        self.left.connect(to: view.left, withOffset: left)
        self.right.connect(to: view.right, withOffset: -right)
        self.top.connect(to: view.top, withOffset: top)
        self.bottom.connect(to: view.bottom, withOffset: -bottom)
        return self
    }

    /// Pin current view's edges view to subview's edges
    ///
    /// - Parameters:
    ///   - left: left inset
    ///   - right: right inset
    ///   - top: top inset
    ///   - bottom: bottom inset
    /// - Returns: Current view
    @discardableResult func pinEdgesToSuperview(left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) -> UIView {

        guard let superview = superview else {
            fatalError("Cennot obtain superview for layouting")
        }

        pinEdges(to: superview, left: left, right: right, top: top, bottom: bottom)

        return self
    }

    /// Pin current view to other view with some offset (to left, right, top and bottom)
    ///
    /// - Parameters:
    ///   - view: Target view
    ///   - offset: [left, right, top, bottom]'s offset
    /// - Returns: Current view
    @discardableResult func pin(to view: UIView, withOffset offset: CGFloat = 0) -> UIView {
        left.connect(to: view.left, withOffset: offset)
        right.connect(to: view.right, withOffset: -offset)
        top.connect(to: view.top, withOffset: offset)
        bottom.connect(to: view.bottom, withOffset: -offset)
        return self
    }

    /// Pin current view to superview with some offset (to left, right, top and bottom)
    ///
    /// - Parameter offset: [left, right, top, bottom]'s offset
    /// - Returns: Current view
    @discardableResult func pinToSuperview(withOffset offset: CGFloat = 0) -> UIView {

        guard let superview = superview else {
            fatalError("Cannot obtain superview for layouting")
        }

        pin(to: superview, withOffset: offset)

        return self
    }

    /// View's sides
    ///
    /// - top: top side
    /// - left: left side
    /// - right: right side
    /// - bottom: bottom side
    enum PinnedSide {
        case top
        case left
        case right
        case bottom
    }

    /// Pin current view to other view excluding some side and using offset
    ///
    /// - Parameters:
    ///   - view: Target view
    ///   - side: Side which should be excluded
    ///   - offset: [left, right, top, bottom]'s offset
    /// - Returns: Current view
    @discardableResult func pin(to view: UIView, excludingSide side: PinnedSide, usingOffset offset: CGFloat = 0) -> UIView {
        switch side {
        case .top:
            pin(to: view, withSides: .left, .right, .bottom, andOffset: offset)
        case .left:
            pin(to: view, withSides: .top, .right, .bottom, andOffset: offset)
        case .right:
            pin(to: view, withSides: .top, .left, .bottom, andOffset: offset)
        case .bottom:
            pin(to: view, withSides: .top, .left, .right, andOffset: offset)
        }
        return self
    }

    /// Pin current view to superview excluding some side and using offset
    ///
    /// - Parameters:
    ///   - side: Side which should be excluded
    ///   - offset: [left, right, top, bottom]'s offset
    /// - Returns: Current view
    @discardableResult func pinToSuperview(excluding side: PinnedSide, usingOffset offset: CGFloat = 0) -> UIView {

        guard let superview = superview else {
            fatalError("There is no superview or sides")
        }

        return pin(to: superview, excludingSide: side, usingOffset: offset)
    }

    /// Pin current view to superview using some sides and offset
    ///
    /// - Parameters:
    ///   - sides: Sides which should be pinned
    ///   - offset: Sides' offset
    /// - Returns: Current view
    @discardableResult func pinToSuperview(withSides sides: PinnedSide..., andOffset offset: CGFloat = 0) -> UIView {

        guard let superview = superview, !sides.isEmpty else {
            fatalError("There is no superview or sides")
        }

        sides.forEach { side in
            switch side {
            case .top:
                top.connect(to: superview.top, withOffset: offset)
            case .right:
                right.connect(to: superview.right, withOffset: -offset)
            case .left:
                left.connect(to: superview.left, withOffset: offset)
            case .bottom:
                bottom.connect(to: superview.bottom, withOffset: -offset)
            }
        }

        return self
    }

    /// Pin current view to other view using some sides and offset
    ///
    /// - Parameters:
    ///   - view: Target view
    ///   - sides: Sides which should be pinned
    ///   - offset: Sides' offset
    /// - Returns: Current view
    @discardableResult func pin(to view: UIView, withSides sides: PinnedSide..., andOffset offset: CGFloat = 0) -> UIView {
        sides.forEach { side in
            switch side {
            case .top:
                top.connect(to: view.top, withOffset: offset)
            case .right:
                right.connect(to: view.right, withOffset: -offset)
            case .left:
                left.connect(to: view.left, withOffset: offset)
            case .bottom:
                bottom.connect(to: view.bottom, withOffset: -offset)
            }
        }
        return self
    }
}
