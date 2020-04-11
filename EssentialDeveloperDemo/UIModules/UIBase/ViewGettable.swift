//
//  ViewGettable.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

protocol ViewGetable {
    static func getView(_ viewModel: PViewModel) -> UIViewController?
    static func setupViewModel<T: PViewModel, S: ViewSettable>(_ viewModel: T?, view: S, addNavigation: Bool, hideTabBar: Bool) -> UIViewController?
    static func setupViewModel<T: PViewModel, S: ViewSettable>(_ viewModel: T?, view: S, addNavigation: Bool) -> UIViewController?
    static func setupViewModel<T: PViewModel, S: ViewSettable>(_ viewModel: T?, view: S, hideTabBar: Bool) -> UIViewController?
    static func setupViewModel<T: PViewModel, S: ViewSettable>(_ viewModel: T?, view: S) -> UIViewController?
}

extension ViewGetable {
    
    static func setupViewModel<T: PViewModel, S: ViewSettable>(_ viewModel: T?, view: S) -> UIViewController? {
        return setupViewModel(viewModel, view: view, addNavigation: false, hideTabBar: false)
    }
    static func setupViewModel<T: PViewModel, S: ViewSettable>(_ viewModel: T?, view: S, addNavigation: Bool) -> UIViewController? {
        return setupViewModel(viewModel, view: view, addNavigation: addNavigation, hideTabBar: false)
    }
    
    static func setupViewModel<T: PViewModel, S: ViewSettable>(_ viewModel: T?, view: S, hideTabBar: Bool) -> UIViewController? {
        return setupViewModel(viewModel, view: view, addNavigation: false, hideTabBar: hideTabBar)
    }
    
    static func setupViewModel<T: PViewModel, S: ViewSettable>(_ viewModel: T?, view: S, addNavigation: Bool, hideTabBar: Bool) -> UIViewController? {
        var _view = view
        _view.viewModel = viewModel as? S.ViewModel
        guard let vc = _view as? UIViewController else { fatalError() }
        vc.hidesBottomBarWhenPushed = hideTabBar
        guard addNavigation  else {
            return vc
        }
        return ViewControllerComposer.createNavigation(vc)
    }
}
