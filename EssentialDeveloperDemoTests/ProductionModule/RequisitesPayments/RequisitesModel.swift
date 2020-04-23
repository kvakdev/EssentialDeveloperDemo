//
//  RequisitesModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/23/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift

protocol RequisitesModelProtocol {
    func searchItems(_ case: SearchQuery) -> Single<[Item]>
}

class RequisitesModel: RequisitesModelProtocol {
    let ibanModel = IbanCellModel(validator: Validator())
    let taxNumberModel = TaxNumberCellModel(validator: Validator())
    
    func didSelect(_ item: Item) {
        if let iban = item.iban {
            ibanModel.text.accept(iban)
        }
        if let taxNumber = item.taxNumber {
            taxNumberModel.text.accept(taxNumber)
        }
    }
    
    func searchItems(_ query: SearchQuery) -> Single<[Item]> {
        switch query {
        case .iban(let text):
            return searchIban(text)
        case .taxNumber(let text):
            return searchTaxNumber(text)
        }
    }
    
    private func searchTaxNumber(_ text: String) -> Single<[Item]> {
        return .just(itemsWith("Tax Payer Number: "))
    }

    
    private func searchIban(_ text: String) -> Single<[Item]> {
        return .just(itemsWith("IBAN: "))
    }
    
    private func itemsWith(_ titlePrefix: String) -> [Item] {
         return (0...10).map { _ in Item.random(titlePrefix) }
    }
}
