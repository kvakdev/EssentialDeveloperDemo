//
//  RequisitesCellViewModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/16/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RequisitesCellViewModelProtocol {
    var title: String { get }
    var text: BehaviorRelay<String> { get }
    var autoCompleteText: PublishSubject<String> { get }
    var errorText: PublishSubject<String?> { get }
    var isKeyboardEnabled: PublishSubject<Bool> { get }
    
    func didChangeText(_ text: String)
    func handleTapAction()
    func handleReturnTap()
}

class RequisitesCellViewModel: NSObject, RequisitesCellViewModelProtocol {
    var title: String { model.requisiteTitle }
    let text: BehaviorRelay<String> = .init(value: "")
    var autoCompleteText: PublishSubject<String> = .init()
    let errorText: PublishSubject<String?> = .init()
    let isKeyboardEnabled: PublishSubject<Bool> = .init()
    
    private let model: RequisitesCellModelProtocol
    private var callback: ((RequisiteType) -> Void)?
    private let disposeBag = DisposeBag()
    
    init(_ model: RequisitesCellModelProtocol) {
        self.model = model
        super.init()
        
        self.setupObservers()
    }
    
    func getType() -> RequisiteType {
        return model.type
    }
    
    func didChangeText(_ text: String) {
        do {
            try model.validateProgress(text)
            autoCompleteText.onNext(text)
            errorText.onNext(nil)
        } catch {
            errorText.onNext(error.localizedDescription)
        }
    }
    
    func handleReturnTap() {
        self.isKeyboardEnabled.onNext(false)
    }
    
    func handleTapAction() {
        self.isKeyboardEnabled.onNext(true)
        callback?(model.type)
    }
    
    func setCallback(_ callback: @escaping (RequisiteType) -> Void) {
        self.callback = callback
    }
    
    private func setupObservers() {
        model.text.subscribe(onNext: { [weak self] text in
            self?.setText(text)
        }).disposed(by: disposeBag)
    }
    
    private func setText(_ text: String) {
        self.text.accept(text)
        do {
            try self.model.validateFinal(text)
            errorText.onNext(nil)
        } catch {
            errorText.onNext(error.localizedDescription)
        }
    }
}
