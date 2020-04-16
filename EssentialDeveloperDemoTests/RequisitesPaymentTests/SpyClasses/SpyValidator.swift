//
//  SpyValidator.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/16/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

class SpyValidator: ValidatorProtocol {
    var progressStrings: [String] = []
    var finalStrings: [String] = []
    
    let error: Error?
    
    init(error: Error? = nil) {
        self.error = error
    }
    
    func validateProgress(_ string: String) throws {
        progressStrings.append(string)
        
        try tryThrowError()
    }
    func validateFinal(_ string: String) throws {
        finalStrings.append(string)
        
        try tryThrowError()
    }
    
    private func tryThrowError() throws {
        if let error = error {
            throw error
        }
    }
}
