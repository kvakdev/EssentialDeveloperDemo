//
//  ViewController.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit
import RxSwift

class RequisitesCellModel {
    
}

class RequisitesCellViewModel: NSObject {
    private let model: RequisitesCellModel
    private var callback: (() -> Void)?
    
    init(_ model: RequisitesCellModel = RequisitesCellModel()) {
        self.model = model
    }
    
    func handleTapAction() {
        callback?()
    }
    
    func setCallback(_ callback: @escaping () -> Void) {
        self.callback = callback
    }
}

class RequisitesSectionViewModel: NSObject {
    let viewModels: [RequisitesCellViewModel]
    
    init(_ cellViewModels: [RequisitesCellViewModel]) {
        self.viewModels = cellViewModels
    }
}

protocol RequisitesPaymentViewModelProtocol: ViewModelProtocol {
    func numberOfRows(in section: Int) -> Int
    func numberOfSections() -> Int
    func viewModel(at indexPath: IndexPath) -> RequisitesCellViewModel?
}

class RequisitesPaymentViewModel: BaseViewModel, RequisitesPaymentViewModelProtocol {
    
    private var sections: [RequisitesSectionViewModel] = []
    
    func setSections(_ sections: [RequisitesSectionViewModel]) {
        self.sections = sections
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 0
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func viewModel(at indexPath: IndexPath) -> RequisitesCellViewModel? {
        guard sections.count > indexPath.section else { return nil }
        
        let section = sections[indexPath.section]
        
        guard section.viewModels.count > indexPath.row else { return nil }
        
        return section.viewModels[indexPath.row]
    }
    
    func handleCallback(_ viewModel: RequisitesCellViewModel) {
        
    }
}

class RequisitesViewController<T: RequisitesPaymentViewModelProtocol>: BaseVC<T> {
    
}

