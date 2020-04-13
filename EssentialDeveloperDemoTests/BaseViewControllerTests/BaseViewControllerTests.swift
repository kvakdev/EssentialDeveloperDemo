//
//  BaseViewControllerTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

class BaseViewControllerTests: XCTestCase {
    
    func test_viewDidLoadIsCalled_onViewLoaded() {
        let (sut, vm) = makeSUT()
        let collector = ResultBag(vm.spyEvents)
        _ = sut.view
        sut.viewWillAppear(false)
        sut.viewDidAppear(false)
        sut.viewWillDisappear(false)
        sut.viewDidDisappear(false)
        
        XCTAssertEqual(collector.values, [.didLoad, .willAppear, .didAppear, .willDissappear, .didDissappear])
    }
    
    func makeSUT() -> (BaseVC<BaseViewModelSpy>, BaseViewModelSpy) {
        let viewModel = BaseViewModelSpy()
        let sut = BaseVC<BaseViewModelSpy>()
        sut.viewModel = viewModel
        
        return (sut, viewModel)
    }
}
