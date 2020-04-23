//
//  RequisitesCellViewModelTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/23/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest

class RequisitesCellViewModelTests: XCTestCase {

    func test_didChangeText_triggersCallback() {
        let sut = makeSUT()
        
        let resultBag = ResultBag(sut.autoCompleteText)
        sut.didChangeText("text1")
        sut.didChangeText("text2")
        XCTAssertEqual(resultBag.values, ["text1", "text2"])
    }
    
    func makeSUT() -> RequisitesCellViewModel {
        return RequisitesCellViewModel(RequisitesCellModel(validator: nil))
    }
}
