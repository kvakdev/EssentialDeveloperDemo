//
//  RequisitePaymentViewControllerTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/20/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest

class RequisitePaymentViewControllerTests: XCTestCase {
    
    func test_sutReloadsTableView_afterReloadEvent() {
        let spyModel = RequisitesModelSpy()
        let datasource = RequisitesTableDataSource()
        datasource.setSections([makeSection(type: .text, cellCount: 10)])
        let vm = RequisitesPaymentViewModel(datasource, model: spyModel)
        let sut = makeSUT(vm)
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), datasource.numberOfRows(in: 0))
        datasource.mode = .search(.iban)
        vm.events.onNext(.reloadSections([0]))
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func makeSection(type: RequisiteType, cellCount: Int) -> RequisitesSectionViewModel {
        let cellViewModels: [RequisitesCellViewModel] = (0..<cellCount).compactMap { _ -> RequisitesCellViewModel in
            let model = RequisitesCellModel(type, validator: SpyValidator())
            let cellViewModel = RequisitesCellViewModel(model)
            return cellViewModel
        }
        return RequisitesSectionViewModel(cellViewModels, type: type)
    }
    
    func makeSUT<T: RequisitesPaymentViewModelProtocol>(_ vm: T) -> RequisitesViewController<T> {
        
        let sut = RequisitesViewController<T>()
        sut.viewModel = vm
        
        return sut
    }
}
