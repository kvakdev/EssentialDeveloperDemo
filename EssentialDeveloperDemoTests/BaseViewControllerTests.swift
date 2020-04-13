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

enum SpyUIEvents {
    case didLoad, willAppear, didAppear, willDissappear
}

class BaseViewModelSpy: ViewModelProtocol {
    let events: PublishSubject<BaseUIEvents> = .init()
    let spyEvents: PublishSubject<SpyUIEvents> = .init()
    
    func viewDidLoad() {
        spyEvents.onNext(.didLoad)
    }
    func viewWillAppear() {
        spyEvents.onNext(.willAppear)
    }
    func viewDidAppear() {
        
    }
    func viewWillDisappear() {
        
    }
    func viewDidDisappear() {
        
    }
}

class BaseViewControllerTests: XCTestCase {
    private let _disposeBag = DisposeBag()
    
    func test_viewDidLoadIsCalled_onViewLoaded() {
        let (sut, vm) = makeSUT()
        let exp = expectation(description: "wainting viewDidLoad")
        vm.spyEvents.subscribe(onNext: { event in
            XCTAssertEqual(event, .didLoad)
            exp.fulfill()
        }).disposed(by: _disposeBag)
        _ = sut.view
        wait(for: [exp], timeout: 1)
    }
    
    func makeSUT() -> (BaseVC<BaseViewModelSpy>, BaseViewModelSpy) {
        let viewModel = BaseViewModelSpy()
        let sut = BaseVC<BaseViewModelSpy>()
        sut.viewModel = viewModel
        
        return (sut, viewModel)
    }
}
