//
//  RequisitesPaymentCellViewModelTests.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/15/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import XCTest

class RequisitesPaymentCellViewModelTests: XCTestCase {

    func test_callbackIsHandledFrom_cellViewModel() {
        let sut = makeSUT()
        let exp = expectation(description: "waiting tap")
        sut.setCallback { _ in
            exp.fulfill()
        }
        
        sut.handleTapAction()
        wait(for: [exp], timeout: 0.2)
    }
    
    func test_cellViewModel_passesModelsValue() {
        let model = RequisitesCellModel(validator: SpyValidator())
        let sut = makeSUT(model)
        let resultBag = ResultBag(sut.text)
        model.text.accept("test")
        XCTAssertEqual(resultBag.values, ["", "test"])
    }
    
    func test_sutCallsValidation_onTextChanged() {
        let spyValidator = SpyValidator()
        let model = RequisitesCellModel(.text, validator: spyValidator)
        let sut = makeSUT(model)
        sut.didChangeText("test")
        sut.didChangeText("test2")
        XCTAssertEqual(spyValidator.progressStrings, ["test", "test2"])
    }
    
    func test_sutErrorText_reflectsValidationErrorText() {
        let messsage = "<Test error>"
        let error = anyError(message: messsage)
        let validator = FailingValidator(error: error)
        let model = RequisitesCellModel(.text, validator: validator)
        let sut = makeSUT(model)
        let resultBag = ResultBag(sut.errorText)
        sut.didChangeText("<some value>")
        XCTAssertEqual(resultBag.values, [messsage])
    }
    
    func test_sutCallsFinalValidation_onPreset() {
        let model = makeAnyModel()
        let sut = makeSUT(model)
    }
    
    func makeSUT(_ model: RequisitesCellModel = RequisitesCellModel(validator: SpyValidator())) -> RequisitesCellViewModel {
        let cellViewModel = RequisitesCellViewModel(model)
        
        return cellViewModel
    }
    
    func makeAnyModel() -> RequisitesCellModel {
        return RequisitesCellModel(validator: SpyValidator())
    }
    
    func anyError(message: String) -> Error {
        return TextError(message)
    }
}

class TextError: LocalizedError {
    var errorDescription: String?
    
    init(_ text: String) {
        errorDescription = text
    }
}
