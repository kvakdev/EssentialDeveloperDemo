//
//  RequisiteCellTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/18/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest
import UIKit
import RxSwift
import RxCocoa

class RequisitesCellViewModelSpy: RequisitesCellViewModelProtocol {
    var title: String = ""
    var autoCompleteText: PublishSubject<String> = .init()
    var text: BehaviorRelay<String> = .init(value: "")
    var errorText: PublishSubject<String?> = .init()
    
    var didCallTextChanged: ((String) -> Void)?
    
    func didChangeText(_ text: String) {
        didCallTextChanged?(text)
    }
    
    func handleTapAction() {
        
    }
}

class RequisiteCellTests: XCTestCase {

    func test_sutChangesTextFieldValue_onViewModelChange() {
        let (sut, vm) = makeSUT()
        XCTAssertEqual(sut.inputTextField.text, "")
        vm.text.accept("preset1")
        XCTAssertEqual(sut.inputTextField.text, "preset1")
    }
    
    func test_sutChangesErrorText_onViewModelChangedError() {
        let (sut, vm) = makeSUT()
        XCTAssertEqual(sut.errorLabel.text, nil)
        vm.errorText.onNext("<someError>")
        XCTAssertEqual(sut.errorLabel.text, "<someError>")
        vm.errorText.onNext(nil)
        XCTAssertEqual(sut.errorLabel.text, nil)
    }
    
    func test_handleText_callsDidChangeTextOnViewModel() {
        let exp = expectation(description: "wait...")
        let text = "test"
        let vmSpy = RequisitesCellViewModelSpy()
        vmSpy.didCallTextChanged = { value in
            XCTAssertEqual(value, text)
            exp.fulfill()
        }
        let (sut, _) = makeSUT(vmSpy)
        sut.handle(text)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_titleLabelText_isTheSameAsViewModelTitleText() {
        let vmSpy = RequisitesCellViewModelSpy()
        vmSpy.title = "<Test title>"
        let (sut, _) = makeSUT(vmSpy)
        
        XCTAssertEqual(sut.cellTitleLabel.text, vmSpy.title)
    }
    
    func test_modelTextChanges_triggersCellLabelTextChange() {
        let model = RequisisteCellModelSpy()
        let vm = RequisitesCellViewModel(model)
        let (sut, viewModel) = makeSUT(vm)
        model.text.accept("test")
        
        XCTAssertEqual(sut.inputTextField.text, model.text.value)
    }
    
    func makeSUT(_ vm: RequisitesCellViewModelProtocol? = nil) -> (RequisiteCell, RequisitesCellViewModelProtocol) {
        let model = RequisisteCellModelSpy()
        let viewModel = RequisitesCellViewModel(model)
        let cell = RequisiteCell()
        cell.setViewModel(vm ?? viewModel)
        
        return (cell, vm ?? viewModel)
    }
}

