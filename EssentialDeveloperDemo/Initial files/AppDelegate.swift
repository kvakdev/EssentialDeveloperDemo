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
        let ibanCellModel = RequisitesCellModel(.iban, validator: Validator(), title: "IBAN")
        let ibanCellViewModel = RequisitesCellViewModel(ibanCellModel)
        let ibanSection = RequisitesSectionViewModel([ibanCellViewModel], type: .iban)
        let taxCellModel = RequisitesCellModel(.taxNumber, validator: Validator(), title: "Tax payer number")
        let taxCellViewModel = RequisitesCellViewModel(taxCellModel)
        let taxSection = RequisitesSectionViewModel([taxCellViewModel], type: .taxNumber)
        let searchSection = RequisitesSectionViewModel([], type: .search)
        dataSource.setSections([ibanSection, taxSection, searchSection])
        
        let vm = RequisitesPaymentViewModel(dataSource, model: model)
        ibanCellViewModel.setCallback { type in
            vm.handleCallback(type)
        }
        vc.viewModel = vm
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
}

