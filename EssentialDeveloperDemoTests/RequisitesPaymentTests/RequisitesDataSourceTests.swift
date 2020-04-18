//
//  RequisitesDataSourceTests.swift
//  RequisitesDataSourceTests
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest


class RequisitesDataSourceTests: XCTestCase {
    
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
    
    func test_SUT_returnsCorrectSearchedSectionCellViewModel() {
        let ibanSection = makeSection(type: .iban, cellCount: 1)
        let regularSection = makeSection(type: .text, cellCount: 2)
        let regularSectionTwo = makeSection(type: .text, cellCount: 2)
        let sut = makeSUT([ibanSection, regularSection, regularSectionTwo])
        
        sut.mode = .all
        
        let sectionOneRows = sut.numberOfRows(in: 0)
        let sectionTwoRows = sut.numberOfRows(in: 1)
        let sectionThreeRows = sut.numberOfRows(in: 2)

        XCTAssertEqual(sectionOneRows, 1)
        XCTAssertEqual(sectionTwoRows, 2)
        XCTAssertEqual(sectionThreeRows, 2)
        
        sut.mode = .search(.iban)
        
        let searchSectionOneRows = sut.numberOfRows(in: 0)
        let searchSectionTwoRows = sut.numberOfRows(in: 1)
        let searchSectionThreeRows = sut.numberOfRows(in: 2)
        
        XCTAssertEqual(searchSectionOneRows, 1)
        XCTAssertEqual(searchSectionTwoRows, 0)
        XCTAssertEqual(searchSectionThreeRows, 0)
    }
    
    func makeSection(type: RequisiteType, cellCount: Int) -> RequisitesSectionViewModel {
        let cellViewModels: [RequisitesCellViewModel] = (0..<cellCount).compactMap { _ -> RequisitesCellViewModel in
            let model = RequisitesCellModel(type, validator: SpyValidator())
            let cellViewModel = RequisitesCellViewModel(model)
            return cellViewModel
        }
        return RequisitesSectionViewModel(cellViewModels)
    }
    
    func makeSUT(_ sections: [RequisitesSectionViewModel] = []) -> RequisitesTableDataSource {
        let sut = RequisitesTableDataSource()
        sut.setSections(sections)
        
        return sut
    }
}
