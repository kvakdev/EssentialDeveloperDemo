//
//  RequisitesCellModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/16/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxCocoa

class RequisitesCellModel {
    let type: RequisiteType
    let text: BehaviorRelay<String> = .init(value: "")
    let validator: ValidatorProtocol
    
    init(_ type: RequisiteType = .text, validator: ValidatorProtocol) {
        self.type = type
        self.validator = validator
    }
    
    func validateProgress(_ string: String) throws {
        try validator.validateProgress(string)
    }
}
