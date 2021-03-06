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

    func validateProgress(_ string: String) throws {
        progressStrings.append(string)
    }
    
    func validateFinal(_ string: String) throws {
        finalStrings.append(string)
    }
}
