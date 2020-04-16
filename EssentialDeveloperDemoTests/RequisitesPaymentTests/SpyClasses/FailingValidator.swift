//
//  FailingValidator.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/16/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

class FailingValidator: ValidatorProtocol {
    let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func validateProgress(_ string: String) throws {
        throw error
    }
    func validateFinal(_ string: String) throws {
        throw error
    }
}
