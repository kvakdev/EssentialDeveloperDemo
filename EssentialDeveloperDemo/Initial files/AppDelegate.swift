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
        let model = RequisitesModel()
        let ibanCellViewModel = RequisitesCellViewModel(model.ibanModel)
        let ibanSection = RequisitesSectionViewModel([ibanCellViewModel], type: .iban)
        let taxCellViewModel = RequisitesCellViewModel(model.taxNumberModel)
        let taxSection = RequisitesSectionViewModel([taxCellViewModel], type: .taxNumber)
        let searchSection = RequisitesSectionViewModel([], type: .search)
        dataSource.setSections([ibanSection, taxSection, searchSection])
        
        let vm = RequisitesPaymentViewModel(dataSource, model: model)
        [ibanCellViewModel, taxCellViewModel].forEach({ cellVM in
            cellVM.setCallback { type in
                vm.handleCallback(type)
            }
        })
        vc.viewModel = vm
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
}

