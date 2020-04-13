//
//  BaseViewModelSpy.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModelSpy: ViewModelProtocol {
    enum SpyUIEvents {
        case didLoad, willAppear, didAppear, willDissappear, didDissappear
    }
    let events: PublishSubject<BaseUIEvents> = .init()
    let spyEvents: PublishSubject<SpyUIEvents> = .init()
    
    func viewDidLoad() {
        spyEvents.onNext(.didLoad)
    }
    func viewWillAppear() {
        spyEvents.onNext(.willAppear)
    }
    func viewDidAppear() {
        spyEvents.onNext(.didAppear)
    }
    func viewWillDisappear() {
        spyEvents.onNext(.willDissappear)
    }
    func viewDidDisappear() {
        spyEvents.onNext(.didDissappear)
    }
}
