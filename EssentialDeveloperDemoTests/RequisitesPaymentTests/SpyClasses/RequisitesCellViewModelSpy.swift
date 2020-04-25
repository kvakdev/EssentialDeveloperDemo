//
//  RequisitesCellViewModelSpy.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 25.04.2020.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RequisitesCellViewModelSpy: RequisitesCellViewModelProtocol {
    let isKeyboardEnabled: PublishSubject<Bool> = .init()
    
    func handleReturnTap() {}
    
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
