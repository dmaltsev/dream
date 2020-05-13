//
//  Constraints.swift
//  Мечта.ру
//

import UIKit

// MARK: - ConstraintAngle

struct ConstraintAngle {

    // MARK: - Properties

    /// First part of angle
    private let first: NSLayoutAnchor<NSLayoutXAxisAnchor>

    /// Second part of angle
    private let second: NSLayoutAnchor<NSLayoutYAxisAnchor>

    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameters:
    ///   - first: first part of angle
    ///   - second: second part of angle
    init(first: NSLayoutAnchor<NSLayoutXAxisAnchor>, second: NSLayoutAnchor<NSLayoutYAxisAnchor>) {
        self.first = first
        self.second = second
    }

    // MARK: - Useful methods

    /// Connect current angle to other angle
    ///
    /// - Parameters:
    ///   - other: target angle
    ///   - offset: offset for constraints
    func connect(to other: ConstraintAngle, withOffset offset: CGFloat = 0) {
        first.constraint(equalTo: other.first, constant: offset).isActive = true
        second.constraint(equalTo: other.second, constant: offset).isActive = true
    }
}

// MARK: - Constraint

struct Constraint<T: AnyObject> {

    // MARK: - Properties

    /// Wrapped constraint
    private let constraint: NSLayoutAnchor<T>

    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter constraint: wrapped constraint
    init(constraint: NSLayoutAnchor<T>) {
        self.constraint = constraint
    }

    // MARK: - Useful methods

    /// Connect current constraint to other constraint
    ///
    /// - Parameters:
    ///   - other: target constraint
    ///   - offset: constraint's offset
    @discardableResult func connect(to other: Constraint<T>, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        let c = constraint.constraint(equalTo: other.constraint, constant: offset)
        c.isActive = true
        return c
    }
    
    /// Set current constraint greater than or equal to other constraint
    ///
    /// - Parameters:
    ///   - other: target constraint
    ///   - c: The constant offset for the constraint
    /// - Returns: An NSLayoutConstraint object
    @discardableResult func greaterThanOrEqual(to other: Constraint<T>, c constant: CGFloat = 0) -> NSLayoutConstraint {
        let c = self.constraint.constraint(greaterThanOrEqualTo: other.constraint, constant: constant)
        c.isActive = true
        return c
    }
    
    /// Set current constraint less than or equal to other constraint
    ///
    /// - Parameters:
    ///   - other: target constraint
    ///   - c: The constant offset for the constraint
    /// - Returns: An NSLayoutConstraint object
    @discardableResult func lessThanOrEqual(to other: Constraint<T>, c constant: CGFloat = 0) -> NSLayoutConstraint {
        let c = constraint.constraint(lessThanOrEqualTo: other.constraint, constant: constant)
        c.isActive = true
        return c
    }

    /// Connect current constraint to other constraint using MetaConstraint
    ///
    /// - Parameter constraint: MetaConstraint instance
    @discardableResult func connect(to constraint: MetaConstraint<T>) -> NSLayoutConstraint {
        return connect(to: constraint.constraint, withOffset: constraint.constant)
    }
}

// MARK: - MetaConstraint

struct MetaConstraint<T: AnyObject> {

    // MARK: - Properties

    /// Wrapped constraint
    let constraint: Constraint<T>

    /// Wrapped constraint's offset
    let constant: CGFloat
}

/// Common `+` operator for making constraints with offsets
///
/// - Parameters:
///   - lhs: constraint which should contain the given offset
///   - offset: offset for the given constraint
/// - Returns: MetaConstraint instance
func + <T>(lhs: Constraint<T>, offset: CGFloat) -> MetaConstraint<T> {
    return MetaConstraint(constraint: lhs, constant: offset)
}

/// Common `-` operator for making constraints with offsets
///
/// - Parameters:
///   - lhs: constraint which should contain the given offset
///   - offset: offset for the given constraint
/// - Returns: MetaConstraint instance
func - <T>(lhs: Constraint<T>, offset: CGFloat) -> MetaConstraint<T> {
    return MetaConstraint(constraint: lhs, constant: -offset)
}

// MARK: - DimensionConstraint

struct DimensionConstraint {

    // MARK: - Properties

    /// Wrapped constraint
    private let constraint: NSLayoutDimension

    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter constraint: wrapped constraint
    init(constraint: NSLayoutDimension) {
        self.constraint = constraint
    }

    // MARK: - Useful methods

    /// Set current constraint equal to other constraint
    ///
    /// - Parameters:
    ///   - other: target constraint
    ///   - multiplier: constraint's multiplier
    @discardableResult func equal(to other: DimensionConstraint, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        let c = self.constraint.constraint(equalTo: other.constraint, multiplier: multiplier)
        c.isActive = true
        return c
    }
    
    /// Set current constraint less than or equal to other constraint
    ///
    /// - Parameters:
    ///   - other: target constraint
    ///   - multiplier: constraint's multiplier
    @discardableResult func lessThanOrEqual(to other: DimensionConstraint,
                                            multiplier: CGFloat = 1,
                                            constant: CGFloat = 0) -> NSLayoutConstraint {
        let c = constraint.constraint(lessThanOrEqualTo: other.constraint,
                                      multiplier: multiplier,
                                      constant: constant)
        c.isActive = true
        return c
    }
    
    /// Set current constraint greater than or equal to other constraint
    ///
    /// - Parameters:
    ///   - other: target constraint
    ///   - multiplier: constraint's multiplier
    @discardableResult func greaterThanOrEqual(to other: DimensionConstraint, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        let c = self.constraint.constraint(greaterThanOrEqualTo: other.constraint, multiplier: multiplier)
        c.isActive = true
        return c
    }
    
    /// Set current constraint greater than or equal to some constant
    ///
    /// - Parameters:
    ///   - constant: some constant
    @discardableResult func greaterThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        let c = self.constraint.constraint(greaterThanOrEqualToConstant: constant)
        c.isActive = true
        return c
    }

    /// Set current constraint less than or equal to some constant
    ///
    /// - Parameters:
    ///   - constant: some constant
    @discardableResult func lessThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        let c = self.constraint.constraint(lessThanOrEqualToConstant: constant)
        c.isActive = true
        return c
    }

    /// Set current constraint equal to some constant
    ///
    /// - Parameter constant: constraint's constant
    @discardableResult func equal(to constant: CGFloat) -> NSLayoutConstraint {
        let c = self.constraint.constraint(equalToConstant: constant)
        c.isActive = true
        return c
    }
}
