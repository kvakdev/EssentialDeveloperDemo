//
//  UIResponder+Notification.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

extension UIResponder {
   /// Get keyboard height with animation duration from Notification
   ///
   /// - Parameter notification: Notification
   /// - Returns: optional (CGFloat, TimeInterval)
   static func getHeightKeyboardWithAnimationDuration(_ notification: Notification) -> (CGFloat, TimeInterval)? {
        guard let info = notification.userInfo else { return nil }
        guard let rect = info[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else { return nil }
        let animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        var kbSize = rect.size
        var keyboardHeight = kbSize.height
        if #available(iOS 11, *) {
            guard let rect = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
            kbSize = rect.size
            keyboardHeight = kbSize.height - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
        }
        return (keyboardHeight, animationDuration)
    }
    /// Get keyboard heigh. if keyboard hidden return 0
    ///
    /// - Returns: CGFloat
    static func getKeyboardHeigh() -> CGFloat {
        let _keyboardClassKey: String = "UIRemoteKeyboardWindow"
        guard let keyboardWindowClass = NSClassFromString(_keyboardClassKey) else { return 0 }
         
        guard let keyboardWindow: UIWindow = UIApplication.shared.windows.first(where: { (window) -> Bool in
            return window.isKind(of: keyboardWindowClass)
        }) else { return 0 }
         
        guard let _view = keyboardWindow.rootViewController?.view.subviews.first else { return 0 }
        return _view.frame.height
    }
     
    struct KeyboardAnimationProperties {
        let height: CGFloat
        let animationDuration: TimeInterval
        let animationCurve: UIView.AnimationCurve
        
        init?(_ notification: Notification) {
            guard let info = notification.userInfo else { return nil }
            guard let rect = info[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else { return nil }
            animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
            var kbSize = rect.size
            var keyboardHeight = kbSize.height
            if #available(iOS 11, *) {
                guard let rect = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
                kbSize = rect.size
                keyboardHeight = kbSize.height - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
            }
            height = keyboardHeight
            guard let value = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int else { return nil }
            animationCurve = UIView.AnimationCurve(rawValue: value) ?? .linear
        }
    }
}
