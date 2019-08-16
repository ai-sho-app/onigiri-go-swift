//
//  CustomUIColor.swift
//  onigiri-go-swift
//
//  Created by Sho Kawasaki on 2019/07/23.
//  Copyright © 2019 Sho Kawasaki. All rights reserved.
//

import UIKit

extension UIColor {
    class var themeOrange: UIColor { return UIColor(code: "FFC700") }
    
    convenience init(code: String) {
        var color: UInt32 = 0
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        if Scanner(string: code.replacingOccurrences(of: "#", with: "")).scanHexInt32(&color) {
            r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            g = CGFloat((color & 0x00FF00) >>  8) / 255.0
            b = CGFloat( color & 0x0000FF       ) / 255.0
        }
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
