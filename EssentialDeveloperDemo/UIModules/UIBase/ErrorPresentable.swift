//
//  ErrorPresentable.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

protocol ErrorPresentable {
    func showWarning(_ message: String, type: WarningType)
    func showWarning(_ message: String, type: WarningType, autoHide: Bool)
    func hideWarning()
    
    var bottomInset: CGFloat { get }
    var needKeyboardCheck: Bool { get }
}
// MARK: ErrorPresentable extension
extension ErrorPresentable where Self: UIViewController {
    /// Show warning or error baner on bottom screen place
    ///
    /// - Parameters:
    ///   - message: Title (String)
    ///   - type: Type baner (ErrorType)
    func showWarning(_ message: String, type: WarningType) {
         showWarning(message, type: type, autoHide: true)
    }
   
    func showWarning(_ message: String, type: WarningType, autoHide: Bool) {
        if let warningView: PSBWarningView = checkView() {
            warningView.setTitle(message)
            warningView.setType(type)
            if autoHide { warningView.updateTimer() }
        } else {
            let warningView = SBWarningView(message, type: type, bottomInset: bottomInset, onTabBar: checkTabbar())
            warningView.alpha = 1
            view.addSubview(warningView)
            warningView.addConstraintsToView(needKeyboardHeight: needKeyboardCheck)
            warningView.show()
            if autoHide { warningView.updateTimer() }
        }
    }
    /// Hide warning
    func hideWarning() {
        guard let warningView: PSBWarningView = checkView() else { return }
        warningView.hideWarning()
    }
    /// Check on exist SBWarningView
    ///
    /// - Returns: optional SBWarningView
    private func checkView() -> SBWarningView? {
        var warningView: SBWarningView?
        view.subviews.forEach { (v) in
            if let wView = v as? SBWarningView {
                warningView = wView
                return
            }
        }
        return warningView
    }
    /// Check tabbar
    ///
    /// - Returns: Bool
    private func checkTabbar() -> Bool {
        guard tabBarController != nil else { return false }
        debugPrint("tabBar != nil")
        guard let nc = navigationController else { return !self.hidesBottomBarWhenPushed }
        guard nc.viewControllers.contains(self) else { return !self.hidesBottomBarWhenPushed }
        
        return !(view.bounds.height == UIScreen.main.bounds.height)
    }
}

