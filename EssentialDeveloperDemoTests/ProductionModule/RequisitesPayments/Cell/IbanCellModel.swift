//
//  IbanCellModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/23/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxCocoa

class IbanCellModel: RequisitesCellModelProtocol {
    let requisiteTitle = "IBAN"
    let text: BehaviorRelay<String> = .init(value: "")
    let type: RequisiteType = .iban
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
