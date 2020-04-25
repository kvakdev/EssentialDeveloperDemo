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
    let autoCompleteText: PublishSubject<String> = .init()
    let text: BehaviorRelay<String> = .init(value: "")
    let errorText: PublishSubject<String?> = .init()
    var title: String = ""
    
    var didCallTextChanged: ((String) -> Void)?
    
    func didChangeText(_ text: String) {
        didCallTextChanged?(text)
    }
    
    func handleReturnTap() {}
    func handleTapAction() {}
}
