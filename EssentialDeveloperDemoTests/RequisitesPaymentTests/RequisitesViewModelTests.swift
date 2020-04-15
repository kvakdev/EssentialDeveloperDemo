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
        let (searchSection, searchCellViewModel) = makeSection(requisiteType)
        let dataSource = RequisitesTableDataSource()
        dataSource.setSections([searchSection])
        
        let (sut, _) = makeSUT(dataSource)
        searchCellViewModel.setCallback { type in
            sut.handleCallback(type)
        }
        searchCellViewModel.handleTapAction()

        switch dataSource.mode {
        case .search(let type):
            XCTAssertEqual(type, requisiteType)
        default:
            XCTFail("searchMode expected")
        }
    }
    
    func makeSection(_ type: RequisiteType) -> (RequisitesSectionViewModel, RequisitesCellViewModel) {
        let model = RequisitesCellModel(type)
        let cellViewModel = RequisitesCellViewModel(model)
        let section = RequisitesSectionViewModel([cellViewModel])
        
        return (section, cellViewModel)
    }
    
    func makeSUT(_ dataSource: RequisitesTableDataSource? = nil) -> (RequisitesPaymentViewModel, RequisitesTableDataSourceProtocol) {
        let source = dataSource ?? RequisitesTableDataSource()
        let sut = RequisitesPaymentViewModel(source)
        
        return (sut, source)
    }

}
