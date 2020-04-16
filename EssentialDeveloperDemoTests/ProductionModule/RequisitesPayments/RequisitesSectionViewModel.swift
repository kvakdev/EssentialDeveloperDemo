//
//  RequisitesSectionViewModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/16/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

class RequisitesSectionViewModel: NSObject {
    let viewModels: [RequisitesCellViewModel]
    
    init(_ cellViewModels: [RequisitesCellViewModel]) {
        self.viewModels = cellViewModels
    }
}
