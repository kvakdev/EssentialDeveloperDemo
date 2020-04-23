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
        let sectionModels = [1...3].compactMap { _ in RequisitesSectionViewModel([], type: .text) }
        let sut = makeSUT(sectionModels)
        XCTAssertEqual(sut.numberOfSections(), sectionModels.count)
    }
    
    func test_returnsCorrectSectionViewModel_forCellAtIndexPath() {
        let firstSection = RequisitesSectionViewModel([], type: .text)
        let model = RequisitesCellModel(.text, validator: SpyValidator())
        let neededCellViewModel = RequisitesCellViewModel(model)
        let secondSectionViewModel = RequisitesSectionViewModel([neededCellViewModel], type: .text)
        let sut = makeSUT([firstSection, secondSectionViewModel])
        let receivedCellViewModel = sut.viewModel(at: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(receivedCellViewModel, neededCellViewModel)
    }
    
    func test_returnNoViewModelsForEmptySectionsArray() {
        XCTAssertNil(makeSUT().viewModel(at: IndexPath(row: 0, section: 0)))
    }
    
    func test_sutReturnCorrectNumberOfRows_forModes() {
        XCTAssertEqual(numberOfRowsFor(.iban, cellCount: 1, in: .search(.iban)), 1)
        XCTAssertEqual(numberOfRowsFor(.iban, cellCount: 1, in: .search(.taxNumber)), 0)
        XCTAssertEqual(numberOfRowsFor(.taxNumber, cellCount: 1, in: .search(.iban)), 0)
        XCTAssertEqual(numberOfRowsFor(.taxNumber, cellCount: 2, in: .search(.taxNumber)), 2)
        XCTAssertEqual(numberOfRowsFor(.taxNumber, cellCount: 1, in: .all), 1)
        XCTAssertEqual(numberOfRowsFor(.text, cellCount: 3, in: .all), 3)
        XCTAssertEqual(numberOfRowsFor(.text, cellCount: 2, in: .search(.taxNumber)), 0)
        XCTAssertEqual(numberOfRowsFor(.text, cellCount: 1, in: .search(.iban)), 0)
        XCTAssertEqual(numberOfRowsFor(.search, cellCount: 10, in: .search(.iban)), 10)
        XCTAssertEqual(numberOfRowsFor(.search, cellCount: 10, in: .all), 0)
    }
    
    func test_numberOfSections_isTheSame() {
        let requisiteModel = RequisitesCellModel(.search, validator: nil, title: "some title")
        let cellViewModel = RequisitesCellViewModel(requisiteModel)
        let searchSection = RequisitesSectionViewModel([cellViewModel], type: .search)
        let sut = makeSUT([makeSection(type: .iban, cellCount: 1), makeSection(type: .taxNumber, cellCount: 1), searchSection])
        let initialSections = sut.numberOfSections()
        sut.mode = .search(.iban)
        let searchNumberOfSections = sut.numberOfSections()
        cellViewModel.handleTapAction()
        XCTAssertEqual(initialSections, searchNumberOfSections)
//        sut.mode = .all
        let finalNumberOfSection = sut.numberOfSections()
        XCTAssertEqual(finalNumberOfSection, initialSections)
    }
    
    func test_sut_returnsCorrectSectionToReload() {
        let model = RequisitesModel()
        let ibanCellViewModel = RequisitesCellViewModel(model.ibanModel)
        let ibanSection = RequisitesSectionViewModel([ibanCellViewModel], type: .iban)
        let taxCellViewModel = RequisitesCellViewModel(model.taxNumberModel)
        let taxSection = RequisitesSectionViewModel([taxCellViewModel], type: .taxNumber)
        let searchSection = RequisitesSectionViewModel([], type: .search)
        let sut = makeSUT([ibanSection, taxSection, searchSection])
        sut.mode = .search(.iban)
        
        XCTAssertEqual(sut.sectionToReload(), [1, 2])
        sut.mode = .search(.taxNumber)
        XCTAssertEqual(sut.sectionToReload(), [0, 2])
    }
    

    func numberOfRowsFor(_ type: RequisiteType, cellCount: Int, in mode: RequisitesPaymentViewModel.Mode) -> Int {
        let sut = makeSUT([makeSection(type: type, cellCount: cellCount)])
        sut.mode = mode
        
        return sut.numberOfRows(in: 0)
    }
    
    func makeSection(type: RequisiteType, cellCount: Int) -> RequisitesSectionViewModel {
        let cellViewModels: [RequisitesCellViewModel] = (0..<cellCount).compactMap { _ -> RequisitesCellViewModel in
            let model = RequisitesCellModel(type, validator: SpyValidator())
            let cellViewModel = RequisitesCellViewModel(model)
            return cellViewModel
        }
        return RequisitesSectionViewModel(cellViewModels, type: type)
    }
    
    
    func makeSUT(_ sections: [RequisitesSectionViewModel] = []) -> RequisitesTableDataSource {
        let sut = RequisitesTableDataSource()
        sut.setSections(sections)
        
        return sut
    }
}
