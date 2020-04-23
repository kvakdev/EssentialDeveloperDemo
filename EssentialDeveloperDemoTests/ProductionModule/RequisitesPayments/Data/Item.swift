//
//  Item.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/23/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

class Item {
    let id: Int
    let iban: String?
    let taxNumber: String?
    let title: String?
    
    internal init(id: Int, iban: String?, taxNumber: String?, title: String?) {
        self.id = id
        self.iban = iban
        self.taxNumber = taxNumber
        self.title = title
    }
    
    static func random(_ titlePrefix: String) -> Item {
        let iban = Int.random(in: 100000000...200000000)
        let taxNumber = Int.random(in: 100000000...200000000)
        let title = Int.random(in: 100000000...200000000)
        return Item(id: Int.random(in: 0...1000), iban: "\(iban)", taxNumber: "\(taxNumber)", title: "\(titlePrefix) \(title)")
    }
}

