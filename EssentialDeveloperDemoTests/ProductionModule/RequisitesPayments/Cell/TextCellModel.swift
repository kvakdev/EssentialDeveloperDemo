//
//  TextCellModel.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 25.04.2020.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxCocoa

class TextCellModel: RequisitesCellModelProtocol {
    let requisiteTitle: String
    let text: BehaviorRelay<String> = .init(value: "")
    let type: RequisiteType = .text
    let validator: ValidatorProtocol?
    
    init(validator: ValidatorProtocol?, title: String) {
        self.validator = validator
        self.requisiteTitle = title
    }

    func validateProgress(_ string: String) throws {
        try validator?.validateProgress(string)
    }
      
    func validateFinal(_ string: String) throws {
        try validator?.validateFinal(string)
    }
}
