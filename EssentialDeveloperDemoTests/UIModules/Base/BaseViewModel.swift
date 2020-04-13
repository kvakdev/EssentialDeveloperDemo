//
//  BaseViewModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel: ViewModelProtocol {
    var events: PublishSubject<BaseUIEvents> = .init()
    

}
