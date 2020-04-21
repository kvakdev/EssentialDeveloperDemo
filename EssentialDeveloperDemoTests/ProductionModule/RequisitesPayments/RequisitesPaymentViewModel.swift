//
//  RequisitesPaymentViewModel.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift

class Item {
    let id: Int
    let iban: String?
    let taxNumber: String?
    let title: String?
    
    internal init(id: Int, iban: String?, taxNumber: String?, title: String?) {
        self.id = id
        self.iban = iban
        self.taxNumber = taxNumber
        self.title = title
    }
    
    static func random() -> Item {
        let iban = Int.random(in: 100000000...200000000)
        let taxNumber = Int.random(in: 100000000...200000000)
        let title = Int.random(in: 100000000...200000000)
        return Item(id: Int.random(in: 0...1000), iban: "\(iban)", taxNumber: "\(taxNumber)", title: "Some title \(title)")
    }
}

protocol RequisitesModelProtocol {
    func searchItems(_ iban: String, taxNumber: String) -> Single<[Item]>
}

class RequisitesModel: RequisitesModelProtocol {
    func searchItems(_ iban: String, taxNumber: String) -> Single<[Item]> {
        let randomItems = (0...10).map { _ in Item.random() }
        
        return .just(randomItems)
    }
}

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
    }
    
    private func searchForIban(_ text: String) {
        model.searchItems(text, taxNumber: "").subscribe(onSuccess: { [weak self] items in
            let cellViewModels = items.compactMap { item -> RequisitesCellViewModel in
                let viewModel = item.toCellViewModel()
                viewModel.setCallback { [weak self] _ in
                    self?.handleSelection(item)
                }
                return viewModel
            }
            
            self?._dataSource.setSearchSection(cellViewModels)
            self?.events.onNext(.reloadSections([1]))
        }, onError: { [weak self] in self?.showError($0) })
        .disposed(by: _disposeBag)
    }
    
    private func handleSelection(_ item: Item) {
        print("selected \(item)")
        let viewModel = _dataSource.getCellViewModel(type: .iban)
        viewModel?.text.accept(item.iban ?? "")
        self._dataSource.mode = .all
        self.events.onNext(.reloadTableView)
    }
    
    private func showError(_ error: Error) {
        //handle error somehow
    }
}

extension Item {
    func toCellViewModel() -> RequisitesCellViewModel {
        let model = RequisitesCellModel(.search, validator: nil)
        model.text.accept("\(self.title ?? "")")
        return RequisitesCellViewModel(model)
    }
}
