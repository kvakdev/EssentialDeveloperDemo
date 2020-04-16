//
//  ResultCollector.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ResultBag<T> {
    private let _disposeBag = DisposeBag()
    var values: [T] = []
    var errors: [Error] = []
    
    init(_ publishSubject: PublishSubject<T>) {
        publishSubject.subscribe(onNext: { [weak self] value in
            self?.values.append(value)
        }).disposed(by: _disposeBag)
    }
    
    init(_ relay: BehaviorRelay<T>) {
        relay.subscribe(onNext: { [weak self] value in
            self?.values.append(value)
        }, onError: { [weak self] error in
            self?.errors.append(error)
        }).disposed(by: _disposeBag)
    }
}
