//
//  ErrorSupportable.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

struct ErrorConfig {
    let onlyConnection: Bool
    let showWarning: Bool
    
    static var `default`: ErrorConfig {
        return ErrorConfig(onlyConnection: false, showWarning: true)
    }
    static var noWarnings: ErrorConfig {
        return ErrorConfig(onlyConnection: false, showWarning: false)
    }
    static var onlyConnection: ErrorConfig {
        return ErrorConfig(onlyConnection: true, showWarning: false)
    }
}

enum ErrorType {
    case visible(WarningType, String)
    case background
}

protocol ErrorSupportable: RoutesSupportable {
   func errorHandling(_ error: Error)
   func errorHandling(_ error: Error, config: ErrorConfig)
}

extension ErrorSupportable {
    func errorHandling(_ error: Error) {
        errorHandling(error, config: ErrorConfig.default)
    }
    
    func errorHandling(_ error: Error, config: ErrorConfig) {
        handleWarning(error: error, config: config)
    }
    
    func handleWarning(error: Error, config: ErrorConfig) {
        let type = error.getWarningType()
        
        guard config.showWarning || config.onlyConnection else { return }
        
        switch type {
        case .error:
            if config.onlyConnection { return }
            
        case .warning(let type):
            switch type {
            case .connection:
                break
            case .server:
                if config.onlyConnection { return }
            }
        case .info:
            break
        }

        coordinator.showWarning(type, message: error.localizedDescription)
    }
}

