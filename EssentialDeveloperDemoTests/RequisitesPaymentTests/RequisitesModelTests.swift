//
//  RequisitesModelTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/23/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest

class RequisitesModelTests: XCTestCase {

    func test_sutSetsCorrectValues_afterItemSelected() {
        let sut = makeSUT()
        let item = Item(id: 1, iban: "1", taxNumber: "20", title: "title1")
        sut.didSelect(item)
        
        XCTAssertEqual(sut.ibanModel.text.value, "1")
        XCTAssertEqual(sut.taxNumberModel.text.value, "20")
    }
    
    func test_sutTogglesIsLoading_whenQueringBankName() {
        let sut = makeSUT()
        let resultBag = ResultBag(sut.isLoading)
        sut.didSelect(Item(id: 0, iban: "123", taxNumber: nil, title: nil))
        wait(for: 2.5)
        XCTAssertEqual(resultBag.values, [true, false])
    }
    
    func makeSUT() -> RequisitesModel {
        return RequisitesModel()
    }
}
