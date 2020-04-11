//
//  Deinitable.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

protocol Deinitable {
    func deinitable()
}

extension Deinitable {
    func deinitable() {
        debugPrint("❌ Deinit \(String(describing: type(of: self)))")
    }
}
