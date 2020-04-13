//
//  EssentialDeveloperDemoTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest
@testable import EssentialDeveloperDemo

class RequisitesPaymentViewModel: BaseViewModel, RequisitesPaymentViewModelProtocol {
    
}

class EssentialDeveloperDemoTests: XCTestCase {
    func test_requisitesViewController_inits() {
        XCTAssertNotNil(RequisitesViewController<RequisitesPaymentViewModel>())
    }
}
