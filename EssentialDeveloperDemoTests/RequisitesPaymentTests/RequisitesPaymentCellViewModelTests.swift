//
//  RequisitesPaymentCellViewModelTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/15/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest

class RequisitesPaymentCellViewModelTests: XCTestCase {

    func test_callbackIsHandledFrom_cellViewModel() {
        let sut = makeSUT()
        let exp = expectation(description: "waiting tap")
        sut.setCallback { _ in
            exp.fulfill()
        }
        
        sut.handleTapAction()
        wait(for: [exp], timeout: 0.2)
    }
    
    func makeSUT() -> RequisitesCellViewModel {
        let cellViewModel = RequisitesCellViewModel()
        
        return cellViewModel
    }
}
