//
//  ViewController.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum RequisiteType {
    case iban
    case taxNumber
    case text
}

protocol ValidatorProtocol {
    func validateProgress(_ string: String) throws
    func validateFinal(_ string: String) throws
}

class SpyValidator: ValidatorProtocol {
    var progressStrings: [String] = []
    var finalStrings: [String] = []
    
    let error: Error?
    
    init(error: Error? = nil) {
        self.error = error
    }
    
    func validateProgress(_ string: String) throws {
        progressStrings.append(string)
        
        try tryThrowError()
    }
    func validateFinal(_ string: String) throws {
        finalStrings.append(string)
        
        try tryThrowError()
    }
    
    private func tryThrowError() throws {
        if let error = error {
            throw error
        }
    }
}


class RequisitesCellModel {
    let type: RequisiteType
    let text: BehaviorRelay<String> = .init(value: "")
    let validator: ValidatorProtocol
    
    init(_ type: RequisiteType = .text, validator: ValidatorProtocol) {
        self.type = type
        self.validator = validator
    }
    
    func validateProgress(_ string: String) throws {
        try validator.validateProgress(string)
    }
}

class RequisitesCellViewModel: NSObject {
    let text: BehaviorRelay<String> = .init(value: "")
    let errorText: PublishSubject<String?> = .init()
    
    private let model: RequisitesCellModel
    private var callback: ((RequisiteType) -> Void)?
    private let disposeBag = DisposeBag()
    
    init(_ model: RequisitesCellModel) {
        self.model = model
        super.init()
        
        self.setupObservers()
    }
    
    func didChangeText(_ text: String) {
        do {
            try model.validateProgress(text)
        } catch {
            errorText.onNext(error.localizedDescription)
        }
    }
    
    func handleTapAction() {
        callback?(model.type)
    }
    
    func setCallback(_ callback: @escaping (RequisiteType) -> Void) {
        self.callback = callback
    }
    
    func setupObservers() {
        model.text.subscribe(onNext: { [weak self] text in
            self?.text.accept(text)
        }).disposed(by: disposeBag)
    }
}

class RequisitesSectionViewModel: NSObject {
    let viewModels: [RequisitesCellViewModel]
    
    init(_ cellViewModels: [RequisitesCellViewModel]) {
        self.viewModels = cellViewModels
    }
}

protocol RequisitesPaymentViewModelProtocol: ViewModelProtocol {
    
}

protocol RequisitesTableDataSourceProtocol {
    func numberOfRows(in section: Int) -> Int
    func numberOfSections() -> Int
    func viewModel(at indexPath: IndexPath) -> RequisitesCellViewModel?
}

class RequisitesPaymentViewModel: BaseViewModel, RequisitesPaymentViewModelProtocol {
    enum Mode {
        case all
        case search(RequisiteType)
    }
    let dataSource: RequisitesTableDataSource
    
    init(_ dataSource: RequisitesTableDataSource) {
        self.dataSource = dataSource
    }
    
    func handleCallback(_ type: RequisiteType) {
        switch type {
        case .iban, .taxNumber:
            dataSource.mode = .search(type)
        case .text:
            dataSource.mode = .all
        }
    }
}

class RequisitesTableDataSource: BaseViewModel, RequisitesTableDataSourceProtocol {
    private var sections: [RequisitesSectionViewModel] = []
    var mode: RequisitesPaymentViewModel.Mode = .all
    
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
}

class RequisitesViewController<T: RequisitesPaymentViewModelProtocol>: BaseVC<T> {
    
}

