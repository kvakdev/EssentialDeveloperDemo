//
//  ViewController.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit
import RxSwift

protocol RequisitesPaymentViewModelProtocol: ViewModelProtocol {
    func numberOfRows(in section: Int) -> Int
    func numberOfSections() -> Int
}

class RequisitesPaymentViewModel: BaseViewModel, RequisitesPaymentViewModelProtocol {
    
    private var sections: [Int] = []
    
    func setSections(_ sections: [Int]) {
        self.sections = sections
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 0
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
}

class RequisitesViewController<T: RequisitesPaymentViewModelProtocol>: BaseVC<T> {
    
}

