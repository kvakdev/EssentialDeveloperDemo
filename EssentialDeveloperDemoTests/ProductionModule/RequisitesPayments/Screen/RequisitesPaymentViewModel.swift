//
//  RequisitesPaymentViewModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift

protocol RequisitesPaymentViewModelProtocol: ViewModelProtocol {
    var dataSource: RequisitesTableDataSourceProtocol { get }
}

class RequisitesPaymentViewModel: BaseViewModel, RequisitesPaymentViewModelProtocol {
    var dataSource: RequisitesTableDataSourceProtocol { _dataSource }
    
    enum Mode {
        case all
        case search(RequisiteType)
    }
    let _dataSource: RequisitesTableDataSource
    let model: RequisitesModelProtocol
    
    private let _disposeBag = DisposeBag()
    
    init(_ dataSource: RequisitesTableDataSource, model: RequisitesModelProtocol?) {
        self._dataSource = dataSource
        self.model = model ?? RequisitesModel()
        
        super.init()
        
        self.setupObservers()
    }
    
    func handleCallback(_ type: RequisiteType) {
        switch type {
        case .iban, .taxNumber:
            _dataSource.mode = .search(type)
            self.events.onNext(.reloadSections([1, 2]))
        case .text:
            _dataSource.mode = .all
        case .search:
            break
        }
    }
    
    private func setupObservers() {
        let ibanViewModel = dataSource.getCellViewModel(type: .iban)
        
        ibanViewModel?.autoCompleteText.subscribe(onNext: { [weak self] value in
            self?.searchForIban(value)
        }).disposed(by: _disposeBag)
        
        let taxNumberViewModel = dataSource.getCellViewModel(type: .taxNumber)
        
        taxNumberViewModel?.autoCompleteText.subscribe(onNext: { [weak self] value in
            self?.searchForTaxNo(value)
        }).disposed(by: _disposeBag)
    }
    
    private func searchForIban(_ text: String) {
        model.searchItems(.iban(text)).subscribe(onSuccess: { [weak self] items in
            self?.handleSearchItems(items)
        }, onError: { [weak self] in self?.showError($0) })
        .disposed(by: _disposeBag)
    }
    
    private func searchForTaxNo(_ text: String) {
        model.searchItems(.taxNumber(text)).subscribe(onSuccess: { [weak self] items in
            self?.handleSearchItems(items)
        }, onError: { [weak self] in self?.showError($0) })
        .disposed(by: _disposeBag)
    }
    
    private func handleSearchItems(_ items: [Item]) {
        let cellViewModels = items.compactMap { item -> RequisitesCellViewModel in
            let viewModel = item.toCellViewModel()
            viewModel.setCallback { [weak self] _ in
                self?.handleSelection(item)
            }
            return viewModel
        }
        
        _dataSource.setSearchSection(cellViewModels)
        events.onNext(.reloadSections([1, 2]))
    }
    
    private func handleSelection(_ item: Item) {
        model.didSelect(item)
        self._dataSource.mode = .all
        self.events.onNext(.reloadTableView)
    }
    
    private func showError(_ error: Error) {
        //handle error somehow
    }
}

private extension Item {
    func toCellViewModel() -> RequisitesCellViewModel {
        let model = RequisitesCellModel(.search, validator: nil)
        model.text.accept("\(self.title ?? "")")
        return RequisitesCellViewModel(model)
    }
}
