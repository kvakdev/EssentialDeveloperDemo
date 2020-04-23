//
//  TaxNumberCellModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/23/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxCocoa

class TaxNumberCellModel: RequisitesCellModelProtocol {
    let requisiteTitle = "Tax number"
    let text: BehaviorRelay<String> = .init(value: "")
    let type: RequisiteType = .taxNumber
    let validator: ValidatorProtocol?
    
    init(validator: ValidatorProtocol?) {
        self.validator = validator
    }

    func validateProgress(_ string: String) throws {
        try validator?.validateProgress(string)
    }
      
    func validateFinal(_ string: String) throws {
        try validator?.validateFinal(string)
    }
}
