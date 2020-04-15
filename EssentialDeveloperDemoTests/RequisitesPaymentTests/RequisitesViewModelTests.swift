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
        
    }
    
    func makeSUT(_ dataSource: RequisitesTableDataSourceProtocol? = nil) -> (RequisitesPaymentViewModel, RequisitesTableDataSourceProtocol) {
        let dataSource = RequisitesTableDataSource()
        let sut = RequisitesPaymentViewModel(dataSource)
        
        return (sut, dataSource)
    }

}
