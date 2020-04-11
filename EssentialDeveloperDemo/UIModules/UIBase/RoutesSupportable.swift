//
//  RoutesSupportable.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation



protocol PServicesPack {
    
}

protocol PCoordinator {
    // MARK: Properties
    var servicePack: PServicesPack? { get set }
    // MARK: Show screens
    func show(_ route: Route, type: PresentationType, animated: Bool)
    func show<R: ViewGetable>(_ route: CommonRoutes<R>, type: PresentationType, animated: Bool)
    func showWarning(_ type: WarningType, message: String)
    func showWarning(_ type: WarningType, message: String, autoHide: Bool)
    func hideWarning()
}

protocol RoutesSupportable {
    var coordinator: PCoordinator { get }
    
    func show<R: ViewGetable>(_ route: CommonRoutes<R>, type: PresentationType, animated: Bool)
    func show<R: ViewGetable>(_ route: CommonRoutes<R>)
}

extension RoutesSupportable {
    /// Full method for show screen at route, presentation type and animated
    ///
    /// - Parameters:
    ///   - route: CommonRoutes<T, R>
    ///   - type: PresentationType
    ///   - animated: Bool
    func show<R: ViewGetable>(_ route: CommonRoutes<R>, type: PresentationType, animated: Bool) {
        coordinator.show(route, type: type, animated: animated)
    }
    /// Compact method for show screen at route
    ///
    /// - Parameter route: CommonRoutes<ViewGetable>
    
    func show<R: ViewGetable>(_ route: CommonRoutes<R>) {
        let animated = route.animated
        let type = route.type
        coordinator.show(route, type: type, animated: animated)
    }
}
