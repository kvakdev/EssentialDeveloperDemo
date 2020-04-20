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
    class RequisiteCell: UITableViewCell {
        let textField = UITextField()
        let errorLabel = UILabel()
        
        private var vm: RequisitesCellViewModelProtocol?
        private let _disposeBag = DisposeBag()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setup() {
            self.textField.rx.controlEvent(.editingChanged)
                .withLatestFrom(textField.rx.text)
                .subscribe(onNext: { [weak self] value in
                    self?.vm?.didChangeText(value ?? "")
            }).disposed(by: _disposeBag)
            
            self.textField.addTarget(self, action: #selector(handle(_:)), for: .editingChanged)
        }
        
        func setViewModel(_ vm: RequisitesCellViewModelProtocol) {
            self.vm = vm
            
            vm.text.subscribe(onNext: { [weak self] text in
                self?.textField.text = text
            }).disposed(by: _disposeBag)
            
            vm.errorText.subscribe(onNext: { [weak self] errorMessage in
                self?.errorLabel.text = errorMessage
            }).disposed(by: _disposeBag)
        }
        
        @objc func handle(_ text: String) {
            self.vm?.didChangeText(text ?? "")
        }
    }
    
    func test_sutChangesTextFieldValue_onViewModelChange() {
        let (sut, vm) = makeSUT()
        XCTAssertEqual(sut.textField.text, "")
        vm.text.accept("preset1")
        XCTAssertEqual(sut.textField.text, "preset1")
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
    
    func makeSUT(_ vm: RequisitesCellViewModelProtocol? = nil) -> (RequisiteCell, RequisitesCellViewModelProtocol) {
        let model = RequisisteCellModelSpy()
        let viewModel = RequisitesCellViewModel(model)
        let cell = RequisiteCell(style: .default, reuseIdentifier: "")
        cell.setViewModel(vm ?? viewModel)
        
        return (cell, vm ?? viewModel)
    }
}

