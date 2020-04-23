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
    
    func makeSUT() -> RequisitesModel {
        return RequisitesModel()
    }
}
