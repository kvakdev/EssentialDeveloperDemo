//
//  CommonRoutes.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit
/// Routes struct with generic where "T - class type" and "R route flow, how example AuthenticationRoutes"
struct CommonRoutes<R: ViewGetable> {
    // MARK: Properties
    /// View presentation type
    private(set) var type: PresentationType
    /// is animated presentation
    var animated: Bool = true
    private let _value: PViewModel
    // MARK: Init
    /// Initialization with PViewModel and PresentationType
    ///
    /// - Parameters:
    ///   - value: T as PViewModel
    ///   - type: PresentationType
    init(_ value: PViewModel, type: PresentationType) {
        _value = value
        self.type = type
    }
    /// Initialization with PViewModel and default PresentationType as .root
    ///
    /// - Parameter value: T as PViewModel
    init(_ value: PViewModel) {
        _value = value
        self.type = .root
    }
    /// Get rout view
    ///
    /// - Returns: optional UIViewController
    func getView() -> UIViewController? {
        return R.getView(_value)
    }
}
