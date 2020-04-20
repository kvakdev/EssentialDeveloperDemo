//
//  RequisitesModelSpy.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/20/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift

class RequisitesModelSpy: RequisitesModelProtocol {
    private var observers = [AnyObserver<[Item]>]()
    var callCount = 0
    
    func searchItems(_ iban: String, taxNumber: String) -> Single<[Item]> {
        callCount += 1
        
        return Observable.create { observer -> Disposable in
            self.observers.append(observer)
            
            return Disposables.create()
        }.asSingle()
    }
    
    func complete(with items: [Item], at index: Int) {
        guard observers.count > index else { return }
        
        let observer = observers[index]
        observer.onNext(items)
    }
}
