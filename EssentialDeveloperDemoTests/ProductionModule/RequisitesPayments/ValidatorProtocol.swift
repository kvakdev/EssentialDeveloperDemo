//
//  ValidatorProtocol.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/16/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

protocol ValidatorProtocol {
    func validateProgress(_ string: String) throws
    func validateFinal(_ string: String) throws
}
