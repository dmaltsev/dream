//
//  PaginationManagerImplementation.swift
//  Мечта.ру
//

import Foundation

// MARK: - PaginationManagerImplementation

class PaginationManagerImplementation {
    
    weak var delegate: PaginationManagerDelegate?
    
    var isLoading: Bool  = false
    var isFinished: Bool = false
    
    private var scrollView: UIScrollView?
    private var observers: [NSKeyValueObservation] = []
    private var nextPageOffset: CGFloat = 0
    
    deinit {
        removeObservers()
    }
    
    private func update(contentOffset: CGPoint, scrollView: UIScrollView) {
        guard !isFinished, !isLoading, nextPageOffset > 0, let delegate = self.delegate else {
            return
        }
        if contentOffset.y + scrollView.frame.height > nextPageOffset {
            isLoading = true
            delegate.needsLoadNextPage()
        }
    }
    
    private func update(contentSize: CGSize, oldContentSize: CGSize, scrollView: UIScrollView) {
        guard contentSize != oldContentSize else {
            return
        }
        let pageHeight = contentSize.height - oldContentSize.height
        let ratio: CGFloat = 0.05
        if pageHeight < 0 {
            nextPageOffset = ratio * oldContentSize.height
        } else {
            nextPageOffset = oldContentSize.height + ratio * pageHeight
        }
    }
    
    private func removeObservers() {
        observers.removeAll()
    }
}

// MARK: - PaginationManager

extension PaginationManagerImplementation: PaginationManager {
    
    func configure(with scrollView: UIScrollView) {
        removeObservers()
        self.scrollView = scrollView
        let contentOffsetObserver = scrollView.observe(\.contentOffset, options: [.new]) { [weak self] scrollView, change in
            guard let contentOffset = change.newValue else {
                return
            }
            self?.update(contentOffset: contentOffset, scrollView: scrollView)
        }
        let contentSizeObserver = scrollView.observe(\.contentSize, options: [.new, .old]) { [weak self] scrollView, change in
            guard let oldContentSize = change.oldValue, let contentSize = change.newValue else {
                return
            }
            self?.update(contentSize: contentSize, oldContentSize: oldContentSize, scrollView: scrollView)
        }
        observers = [contentOffsetObserver, contentSizeObserver]
    }
    
    func endLoading(finish: Bool) {
        isFinished = finish
        isLoading = false
    }
}
