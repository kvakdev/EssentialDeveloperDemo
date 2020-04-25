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
    private var _searchDisposeBag = DisposeBag()
    
    init(_ dataSource: RequisitesTableDataSource, model: RequisitesModelProtocol?) {
        self._dataSource = dataSource
        self.model = model ?? RequisitesModel()
        
        super.init()
        
        self.setupObservers()
    }
    
    func handleCallback(_ type: RequisiteType) {
        switch type {
        case .iban:
            _dataSource.mode = .search(type)
            self.events.onNext(.reloadSections([1, 2]))
        case .taxNumber:
            _dataSource.mode = .search(type)
            self.events.onNext(.reloadSections([0, 2]))
        case .text:
            _dataSource.mode = .all
        case .search:
            break
        }
    }
    
    private func setupObservers() {
        let types: [RequisiteType] = [.iban, .taxNumber]
        types.forEach { type in
            let viewModel = dataSource.getCellViewModel(type: type)
            
            viewModel?.autoCompleteText.subscribe(onNext: { [weak self] value in
                self?.searchForType(type: type, text: value)
            }).disposed(by: _disposeBag)
            
            viewModel?.isKeyboardEnabled.filter { !$0 }.subscribe(onNext: { [weak self] _ in
                self?.resetMode()
            }).disposed(by: _disposeBag)
        }
    }
    
    private func searchForType(type: RequisiteType, text: String) {
        switch type {
        case .iban:
            searchForIban(text)
        case .taxNumber:
            searchForTaxNo(text)
        default: break
        }
    }
    
    private func searchForIban(_ text: String) {
        model.searchItems(.iban(text)).subscribe(onSuccess: { [weak self] items in
            self?.handleSearchItems(items)
        }, onError: { [weak self] in self?.showError($0) })
        .disposed(by: _searchDisposeBag)
    }
    
    private func searchForTaxNo(_ text: String) {
        model.searchItems(.taxNumber(text)).subscribe(onSuccess: { [weak self] items in
            self?.handleSearchItems(items)
        }, onError: { [weak self] in self?.showError($0) })
        .disposed(by: _searchDisposeBag)
    }
    
    private func handleSearchItems(_ items: [Item]) {
        let cellViewModels = items.compactMap { item -> RequisitesCellViewModel in
            let viewModel = item.toCellViewModel()
            viewModel.setCallback { [weak self] _ in
                self?.handleSelection(item)
            }
            return viewModel
        }
        _searchDisposeBag = .init()
        _dataSource.setSearchSection(cellViewModels)
        events.onNext(.reloadSections(_dataSource.sectionToReload()))
    }
    
    private func resetMode() {
        self._searchDisposeBag = .init()
        self._dataSource.setSearchSection([])
        self._dataSource.mode = .all
        self.events.onNext(.reloadTableView)
    }
    
    private func handleSelection(_ item: Item) {
        model.didSelect(item)
        resetMode()
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
