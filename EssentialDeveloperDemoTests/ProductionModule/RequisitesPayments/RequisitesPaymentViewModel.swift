//
//  RequisitesPaymentViewModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

protocol RequisitesPaymentViewModelProtocol: ViewModelProtocol {
    
}

class RequisitesPaymentViewModel: BaseViewModel, RequisitesPaymentViewModelProtocol {
    enum Mode {
        case all
        case search(RequisiteType)
    }
    let dataSource: RequisitesTableDataSource
    
    init(_ dataSource: RequisitesTableDataSource) {
        self.dataSource = dataSource
    }
    
    func handleCallback(_ type: RequisiteType) {
        switch type {
        case .iban, .taxNumber:
            dataSource.mode = .search(type)
        case .text:
            dataSource.mode = .all
        }
    }
}
