//
//  ViewControllerComposer.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

struct ViewControllerComposer {
    /// create UINavigationController with root view controller
    ///
    /// - Parameter vc: UIViewController
    /// - Returns: UINavigationController
    static func createNavigation(_ vc: UIViewController) -> UINavigationController {
        var navigationController: UINavigationController?
        if #available(iOS 13.0, *) {
            navigationController =  UINavigationController13(rootViewController: vc)
        } else {
            navigationController = UINavigationController(rootViewController: vc)
        }
        navigationController?.navigationBar.shadowImage = UIImage()
        guard let _navigationController = navigationController else {
            return UINavigationController(rootViewController: vc)
        }
        return _navigationController
    }
    
    static func addNavigation(_ array: [UIViewController]) -> [UINavigationController] {
        var returnArray: [UINavigationController] = []
        array.forEach { returnArray.append(createNavigation($0)) }
        return returnArray
    }
}

class UINavigationController13: UINavigationController {
    
}
