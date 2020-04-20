//
//  AppDelegate.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        showFirstScreen()
        
        return true
    }
    
    private func showFirstScreen() {
        let vc = RequisitesViewController<RequisitesPaymentViewModel>()
        let dataSource = RequisitesTableDataSource()
        let cellModel = RequisitesCellModel(.iban, validator: Validator(), title: "IBAN")
        let section = RequisitesSectionViewModel([RequisitesCellViewModel(cellModel)], type: .iban)
        dataSource.setSections([section])
        let model = RequisitesModel()
        let vm = RequisitesPaymentViewModel(dataSource, model: model)
        vc.viewModel = vm
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
}

