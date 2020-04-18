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

class RequisitesCellViewModel: NSObject {
    let text: BehaviorRelay<String> = .init(value: "")
    let errorText: PublishSubject<String?> = .init()
    
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
        } catch {
            errorText.onNext(error.localizedDescription)
        }
    }
    
    func handleTapAction() {
        callback?(model.type)
    }
    
    func setCallback(_ callback: @escaping (RequisiteType) -> Void) {
        self.callback = callback
    }
    
    func setupObservers() {
        model.text.subscribe(onNext: { [weak self] text in
            self?.text.accept(text)
        }).disposed(by: disposeBag)
    }
}
