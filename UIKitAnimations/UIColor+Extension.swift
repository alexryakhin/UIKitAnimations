//
//  UIColor+Extension.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/11/23.
//

import UIKit

extension UIColor {

    static var random: UIColor {
        switch Int.random(in: 0..<6) {
        case 0: return UIColor.green
        case 1: return UIColor.blue
        case 2: return UIColor.yellow
        case 3: return UIColor.magenta
        case 4: return UIColor.cyan
        default: return UIColor.red
        }
    }
}
