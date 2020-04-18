//
//  RequisisteCellModelSpy.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/18/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxCocoa

class RequisisteCellModelSpy: RequisitesCellModelProtocol {
    var type: RequisiteType = .text
    var text: BehaviorRelay<String> = .init(value: "")
    
    var progressValidationCalls = 0
    var finalValidationCalls = 0
    
    func validateProgress(_ string: String) throws {
        progressValidationCalls += 1
    }
    
    func validateFinal(_ string: String) throws {
        finalValidationCalls += 1
    }
}
