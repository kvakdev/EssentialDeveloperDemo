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
        let sectionModels = [1...3].compactMap { _ in RequisitesCellViewModel() }
        let sut = makeSUT(sectionModels)
        XCTAssertEqual(sut.numberOfSections(), sectionModels.count)
    }
    
    func test_returnsCorrectViewModel_forCellAtIndexPath() {
        let neededCellViewModel = RequisitesCellViewModel()
        let sut = makeSUT([neededCellViewModel])
        let receivedCellViewModel = sut.viewModel(at: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(receivedCellViewModel, neededCellViewModel)
    }
    
    func test_returnNoViewModelsForEmptySectionsArray() {
        XCTAssertNil(makeSUT().viewModel(at: IndexPath(row: 0, section: 0)))
    }
    
    func test_callbackIsHandledFrom_cellViewModel() {
        
    }
    
    func makeSUT(_ sections: [RequisitesCellViewModel] = []) -> RequisitesPaymentViewModelProtocol {
        let sut = RequisitesPaymentViewModel()
        sut.setSections(sections)
        
        return sut
    }
}
