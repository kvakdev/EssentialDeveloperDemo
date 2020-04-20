//
//  RequisitesSectionViewModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/16/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

class RequisitesSectionViewModel: NSObject {
    let type: RequisiteType
    private(set) var viewModels: [RequisitesCellViewModel]
    
    init(_ cellViewModels: [RequisitesCellViewModel], type: RequisiteType) {
        self.viewModels = cellViewModels
        self.type = type
    }
    
    func set(_ viewModels: [RequisitesCellViewModel]) {
        self.viewModels = viewModels
    }
}
