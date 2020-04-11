//
//  UIView+Constraints.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraints(subview: UIView) {
        addConstraints(subview: subview, insets: UIEdgeInsets.zero)
    }
    
    func addConstraints(subview: UIView, insets: UIEdgeInsets) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: insets.right).isActive = true
        subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: insets.bottom).isActive = true
    }
    
    func addConstraints(_ subview: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) -> ViewConstraints {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let left = subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
        let right = trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: insets.right)
        let top = subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        let bottom = bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: insets.bottom)
        
        [top, bottom, left, right].forEach { $0.isActive = true }
        
        return ViewConstraints(top: top, bottom: bottom, left: left, right: right)
    }
    
    struct ViewConstraints {
        var top, bottom, left, right: NSLayoutConstraint
    }
}
