//
//  RequisitesViewModelTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/15/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest

class RequisitesViewModelTests: XCTestCase {

    func test_modeChanges_afterIbanCallback() {
        let requisiteType = RequisiteType.iban
        let mode = modeChangesAfterCallback(with: requisiteType)
        switch mode {
        case .search(let type):
            XCTAssertEqual(type, requisiteType)
        case .all:
            XCTFail("searchMode expected got \(mode) instead")
        }
    }
    
    func test_modeChanges_afterTaxNumberCallback() {
        let requisiteType = RequisiteType.taxNumber
        let mode = modeChangesAfterCallback(with: requisiteType)
        switch mode {
        case .search(let type):
            XCTAssertEqual(type, requisiteType)
        case .all:
            XCTFail("searchMode expected got \(mode) instead")
        }
    }
    
    func test_searchModeChange_sendsCorrectReloadTableSectionEvent() {
        let dataSource = RequisitesTableDataSource()
        let (ibanSection, ibanCellViewModel) = makeSection(.iban)
        let taxSection = makeSection(.taxNumber).0
        let textSection = makeSection(.text).0
        let sections = [ibanSection,
                        taxSection,
                        textSection]
        
        dataSource.setSections(sections)
        let (sut, _) = makeSUT(dataSource)
        let resultBag = ResultBag(sut.events)
        ibanCellViewModel.setCallback { type in
            sut.handleCallback(type)
        }
        ibanCellViewModel.handleTapAction()
        
        guard let lastEvent = resultBag.values.last else {
            XCTFail("no events in the bag")
            return
        }
        
        switch lastEvent {
        case BaseUIEvents.reloadSections([1, 2]):
            break
        default:
            XCTFail("incorrect events")
        }
    }
    
    private func modeChangesAfterCallback(with requisiteType: RequisiteType) -> RequisitesPaymentViewModel.Mode {
        let (searchSection, searchCellViewModel) = makeSection(requisiteType)
        let dataSource = RequisitesTableDataSource()
        dataSource.setSections([searchSection])
        
        let (sut, _) = makeSUT(dataSource)
        searchCellViewModel.setCallback { type in
            sut.handleCallback(type)
        }
        searchCellViewModel.handleTapAction()
        
        return dataSource.mode
    }
    
    private func makeSection(_ type: RequisiteType) -> (RequisitesSectionViewModel, RequisitesCellViewModel) {
        let model = RequisitesCellModel(type, validator: SpyValidator())
        let cellViewModel = RequisitesCellViewModel(model)
        let section = RequisitesSectionViewModel([cellViewModel])
        
        return (section, cellViewModel)
    }
    
    private func makeSUT(_ dataSource: RequisitesTableDataSource? = nil) -> (RequisitesPaymentViewModel, RequisitesTableDataSourceProtocol) {
        let source = dataSource ?? RequisitesTableDataSource()
        let sut = RequisitesPaymentViewModel(source)
        
        return (sut, source)
    }

}
