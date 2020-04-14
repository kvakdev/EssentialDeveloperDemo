//
//  ViewController.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit
import RxSwift

class RequisitesCellViewModel: NSObject {
    
}

protocol RequisitesPaymentViewModelProtocol: ViewModelProtocol {
    func numberOfRows(in section: Int) -> Int
    func numberOfSections() -> Int
    func viewModel(at indexPath: IndexPath) -> RequisitesCellViewModel?
}

class RequisitesPaymentViewModel: BaseViewModel, RequisitesPaymentViewModelProtocol {
    
    private var sections: [RequisitesCellViewModel] = []
    
    func setSections(_ sections: [RequisitesCellViewModel]) {
        self.sections = sections
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 0
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func viewModel(at indexPath: IndexPath) -> RequisitesCellViewModel? {
        guard sections.count > indexPath.row else { return nil }
        return sections[indexPath.row]
    }
}

class RequisitesViewController<T: RequisitesPaymentViewModelProtocol>: BaseVC<T> {
    
}

