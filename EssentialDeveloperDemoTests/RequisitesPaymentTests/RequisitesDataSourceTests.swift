//
//  RequisitesDataSourceTests.swift
//  RequisitesDataSourceTests
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest


class EssentialDeveloperDemoTests: XCTestCase {
    
    func test_requisitesViewController_inits() {
        XCTAssertNotNil(RequisitesViewController<RequisitesPaymentViewModel>())
    }
    
    func test_dataSource_hasNumberOfRowsInSection() {
        let sut = makeSUT()
        let rowsCount = sut.numberOfRows(in: 0)
        XCTAssertNotNil(rowsCount)
    }
    
    func test_numberOfSections_isEqualToNumberOfSectionModels() {
        let sectionModels = [1...3].compactMap { _ in RequisitesSectionViewModel([]) }
        let sut = makeSUT(sectionModels)
        XCTAssertEqual(sut.numberOfSections(), sectionModels.count)
    }
    
    func test_returnsCorrectSectionViewModel_forCellAtIndexPath() {
        let firstSection = RequisitesSectionViewModel([])
        let model = RequisitesCellModel(.text, validator: SpyValidator())
        let neededCellViewModel = RequisitesCellViewModel(model)
        let secondSectionViewModel = RequisitesSectionViewModel([neededCellViewModel])
        let sut = makeSUT([firstSection, secondSectionViewModel])
        let receivedCellViewModel = sut.viewModel(at: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(receivedCellViewModel, neededCellViewModel)
    }
    
    func test_returnNoViewModelsForEmptySectionsArray() {
        XCTAssertNil(makeSUT().viewModel(at: IndexPath(row: 0, section: 0)))
    }
    
    func makeSUT(_ sections: [RequisitesSectionViewModel] = []) -> RequisitesTableDataSourceProtocol {
        let sut = RequisitesTableDataSource()
        sut.setSections(sections)
        
        return sut
    }
}
