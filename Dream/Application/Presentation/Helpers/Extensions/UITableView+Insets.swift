//
//  UITableView.swift
//  Мечта.ру
//

import Foundation
import UIKit

extension UITableView {
    
    func animateContentInset(_ inset: UIEdgeInsets) {
        
        let contentOffset = self.contentOffset
        UIView.animate(withDuration: 0.2) {
            self.contentInset = inset
            self.contentOffset = contentOffset
        }
        
    }
    
}
