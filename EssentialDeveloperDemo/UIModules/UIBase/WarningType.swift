//
//  WarningType.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation


enum WarningType {
    var isConnection: Bool {
        switch self {
        case .warning(let icon): return icon == .connection
        default: return false
        }
    }
    
    case warning(ErrorPresentableIcons)
    case info(ErrorPresentableInfoColors)
    case error
    
    enum ErrorPresentableIcons {
        case connection
        case server
    }
    
    enum ErrorPresentableInfoColors {
        case gray
        case green
        case red
        case orange
    }
}
