//
//  Error+WarningType.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import Moya

extension Error {
    func getWarningType() -> WarningType {
        if let moyaError = self as? MoyaError {
            switch moyaError {
            case .underlying(let value, _):
                return createType(value as NSError)
            default: break
            }
        }
        return .error
    }
    
    private func createType(_ _error: NSError) -> WarningType {
        switch _error.code {
        case -1009:
            return .warning(.connection)
        case -1003:
            return .warning(.server)
        default:
            return .error
        }
    }
}
