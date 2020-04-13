//
//  ResultCollector.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift

class ResultCollector<T> {
    private let _disposeBag = DisposeBag()
    var values: [T] = []
    
    init(_ publishSubject: PublishSubject<T>) {
        publishSubject.subscribe(onNext: { [weak self] value in
            self?.values.append(value)
        }).disposed(by: _disposeBag)
    }
}
