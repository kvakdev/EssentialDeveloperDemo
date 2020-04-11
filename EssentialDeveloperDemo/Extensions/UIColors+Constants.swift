//
//  UIColors+Constants.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit


extension UIColor {
     // Application colors
    enum SBColors: String {
        case _000000 = "000000"
        case _5BCA78 = "5BCA78"
        case _E5E5E5 = "E5E5E5" // UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        case _299C48 = "299C48" // green - newGreen
        case _ACACAC = "ACACAC" // UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1)
        case _EB5757 = "EB5757" // red
        case _F2994A = "F2994A" // orange
        case _333333 = "333333" // New black
        case _828282 = "828282" // light gray
        case _DEE0E2 = "DEE0E2" // grey disabled
        case _299D48 = "299D48" // green enabled
        case _53CB7E = "53CB7E" // green
        case _4F4F4F = "4F4F4F"
        case _FEA21E = "FEA21E" // orange1
        case _FF8407 = "FF8407" // orange2
        case _CCCCCC = "CCCCCC" // grey2
        case _5D5D5D = "5D5D5D"
        case _A1A1A1 = "A1A1A1"
        case _3F3F3F = "3F3F3F"
        case _434242 = "434242"
        case _191919 = "191919"
        case _47D57A = "47D57A"
        case _16964D = "16964D"
        case _DADADA = "DADADA"
        case _31AD55 = "31AD55"
        case _F8F9F9 = "F8F9F9"
        case _FDA620 = "FDA620"
        
        func color() -> UIColor {
            return UIColor(hex: self.rawValue)
        }
        
        func color(_ alpha: CGFloat) -> UIColor {
            return UIColor(hex: self.rawValue).withAlphaComponent(alpha)
        }
    }
}


public extension UIColor {
    static let _00__90 = SBColors._000000.color(0.9)
    static let _00__70 = SBColors._000000.color(0.7)
    static let _5BCA78 = SBColors._5BCA78.color()
    static let _E5E5E5 = SBColors._E5E5E5.color()
    static let _299C48 = SBColors._299C48.color()
    static let _ACACAC = SBColors._ACACAC.color()
    static let _EB5757 = SBColors._EB5757.color()
    static let _F2994A = SBColors._F2994A.color()
    static let _333333 = SBColors._333333.color()
    static let _828282 = SBColors._828282.color()
    static let _DEE0E2 = SBColors._DEE0E2.color()
    static let _299D48 = SBColors._299D48.color()
    static let _53CB7E = SBColors._53CB7E.color()
    static let _4F4F4F = SBColors._4F4F4F.color()
    static let _FEA21E = SBColors._FEA21E.color()
    static let _FF8407 = SBColors._FF8407.color()
    static let _CCCCCC = SBColors._CCCCCC.color()
    static let _5D5D5D = SBColors._5D5D5D.color()
    static let _A1A1A1 = SBColors._A1A1A1.color()
    static let _3F3F3F = SBColors._3F3F3F.color()
    static let _434242 = SBColors._434242.color()
    static let _191919 = SBColors._191919.color()
    static let _47D57A = SBColors._47D57A.color()
    static let _16964D = SBColors._16964D.color()
    static let _DADADA = SBColors._DADADA.color()
    static let _31AD55 = SBColors._31AD55.color()
    static let _F8F9F9 = SBColors._F8F9F9.color()
    static let _FDA620 = SBColors._FDA620.color()
//
//    // Old colors
//    static let labelCoolGray =      UIColor(red: 68 / 255, green: 68 / 255, blue: 68 / 255, alpha: 0.7)
//    static let coolGreen =          UIColor(red: 26 / 255, green: 160 / 255, blue: 40 / 255, alpha: 1)
//    static let coolGreen10 =        UIColor(red: 26 / 255, green: 160 / 255, blue: 40 / 255, alpha: 0.1)
//    static let titleOrange =        UIColor(red: 245 / 255, green: 166 / 255, blue: 35 / 255, alpha: 1)
//    static let labelGray =          UIColor(red: 111 / 255, green: 111 / 255, blue: 111 / 255, alpha: 1)
//    static let lightGray1 =         UIColor(red: 216 / 255, green: 216 / 255, blue: 216 / 255, alpha: 1)
//    static let lightGrayPlus =      UIColor(red: 206 / 255, green: 206 / 255, blue: 210 / 255, alpha: 1)
//    static let borderGrayColor =    UIColor(red: 233 / 255, green: 233 / 255, blue: 233 / 255, alpha: 1)
//    static let tableViewGray =      UIColor(red: 252 / 255, green: 252 / 255, blue: 252 / 255, alpha: 1)
//    static let blackTwo =           UIColor(red: 48 / 255, green: 48 / 255, blue: 48 / 255, alpha: 1)
//    static let newGray =            UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
//    static let gray67 =             UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1)
//
//    static let disabledGray = UIColor(red: 0.87, green: 0.88, blue: 0.89, alpha: 1)
//    static let darkerGray = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1)
//    static let errorRed = UIColor(red: 0.92, green: 0.34, blue: 0.34, alpha: 1)
//    static let gray85 = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
}
