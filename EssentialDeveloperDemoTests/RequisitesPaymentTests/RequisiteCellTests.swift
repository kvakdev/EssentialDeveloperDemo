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
        vm.errorText.accept("<someError>")
        XCTAssertEqual(sut.errorLabel.text, "<someError>")
        vm.errorText.accept(nil)
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
        let (sut, _) = makeSUT(vm)
        model.text.accept("test")
        
        XCTAssertEqual(sut.inputTextField.text, model.text.value)
    }
    
    func test_errorLabelIsEmpty_afterReuse() {
        let model = RequisisteCellModelSpy()
        let vm = RequisitesCellViewModel(model)
        let (sut, _) = makeSUT(vm)
        vm.errorText.accept("error")
        XCTAssertEqual(sut.errorLabel.text, "error")
        sut.prepareForReuse()
        XCTAssertEqual(sut.errorLabel.text, "")
    }
    ///Wrong test #2
//    func test_textFieldEndsEditing_onViewModelKeyboardEnabled() {
//        let (sut, vm) = makeSUT()
//        vm.isKeyboardEnabled.onNext(false)
//        XCTAssertFalse(sut.inputTextField.isEditing)
//        vm.isKeyboardEnabled.onNext(true)
//        XCTAssertTrue(sut.inputTextField.isEditing)
//    }
    
    func makeSUT(_ vm: RequisitesCellViewModelProtocol? = nil) -> (RequisiteCell, RequisitesCellViewModelProtocol) {
        let model = RequisisteCellModelSpy()
        let viewModel = RequisitesCellViewModel(model)
        let cell = RequisiteCell()
        cell.setViewModel(vm ?? viewModel)
        
        return (cell, vm ?? viewModel)
    }
}

