//
//  EssentialDeveloperDemoTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest


class EssentialDeveloperDemoTests: XCTestCase {
    
    func test_requisitesViewController_inits() {
        XCTAssertNotNil(RequisitesViewController<RequisitesPaymentViewModel>())
    }
    
    func test_viewModel_hasNumberOfRowsInSection() {
        let sut = makeSUT()
        let rowsCount = sut.numberOfRows(in: 0)
        XCTAssertNotNil(rowsCount)
    }
    
    func test_numberOfSections_isEqualToNumberOfSectionModels() {
        let sectionModels: [Int] = [1,2,3]
        let sut = makeSUT(sectionModels)
        XCTAssertEqual(sut.numberOfSections(), sectionModels.count)
    }
    
    func makeSUT(_ sections: [Int] = []) -> RequisitesPaymentViewModelProtocol {
        let sut = RequisitesPaymentViewModel()
        sut.setSections(sections)
        
        return sut
    }
}
