//
//  RequisitesModelTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/23/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest

class RequisitesModelTests: XCTestCase {

    func test_sutMakesModel_whenValueIsSet() {
        let sut = makeSUT()
        sut.setIBAN("123")
        XCTAssertEqual(sut.ibanModel.text.value, "123")
    }
    
    func makeSUT() -> RequisitesModel {
        return RequisitesModel()
    }
}
