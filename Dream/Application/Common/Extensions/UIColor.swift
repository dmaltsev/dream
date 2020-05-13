//
//  UIColor.swift
//  Dream
//
//  Created by denis on 06.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha:1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(netHex:Int, alpha:Float) {
        self.init(red: CGFloat((netHex >> 16) & 0xff) / 255.0, green: CGFloat((netHex >> 8) & 0xff) / 255.0, blue: CGFloat(netHex & 0xff) / 255.0, alpha:CGFloat(alpha))
    }
    
    static var backgroundGray: UIColor {
        return UIColor(netHex: 0xF7F7F7)
    }
    
    static var underlineGray: UIColor {
        return UIColor(netHex: 0x979797)
    }
    
    static var pagerGray: UIColor {
        return UIColor(netHex: 0xE5E5E5)
    }
    
    static var buttonRedLabel: UIColor {
        return UIColor(netHex: 0xDA1C5C)
    }
    
    static var buttonRedColor: UIColor {
        return UIColor(netHex: 0xDA1C5C)
    }
    
    static var buttonOrangeColor: UIColor {
        return UIColor(netHex: 0xF15A29)
    }
    
    static var darkTextColor: UIColor {
        return UIColor(netHex: 0x393939)
    }
    
    static var pagerRed: UIColor {
        return UIColor(netHex: 0xDA1C5C)
    }
    
    static var redNavBar: UIColor {
        return UIColor(netHex: 0xDA1C5C)
    }
    
    static var pageLightGray: UIColor {
        return UIColor(netHex: 0xDADADA)
    }
    
    static var textFieldStoke: UIColor {
        return UIColor(netHex: 0xDADADA)
    }
    
    static var commentsBackgroundColor: UIColor {
        return UIColor(netHex: 0xF7F7F7)
    }
    
    static var sideMenuBackground: UIColor {
        return UIColor(netHex: 0xDADADA)
    }
}
