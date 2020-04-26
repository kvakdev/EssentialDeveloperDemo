//
//  Validator.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/20/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

class MinSymbolsError: LocalizedError {
    var errorDescription: String?
    
    init(_ minSymbols: Int) {
        self.errorDescription = "At least \(minSymbols) required"
    }
}

class Validator: ValidatorProtocol {
    private let minSymbols: Int
    
    init(minSymbols: Int = 5) {
        self.minSymbols = minSymbols
    }
    
    func validateProgress(_ string: String) throws {
    
    }
    
    func validateFinal(_ string: String) throws {
        if string.count < minSymbols {
            throw MinSymbolsError(minSymbols)
        }
    }
}
