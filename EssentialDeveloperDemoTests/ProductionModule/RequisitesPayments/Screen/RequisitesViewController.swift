//
//  ViewController.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

class RequisitesViewController<T: RequisitesPaymentViewModelProtocol>: BaseVC<T>, UITableViewDataSource, UITableViewDelegate {
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        self.title = "Payment requisites"
    }
    
    fileprivate func setupSubviews() {
        tableView.frame = self.view.bounds
        
        view.addSubview(tableView)
        
        tableView.register(RequisiteCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func setup(_ viewModel: T) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        viewModel.events.subscribe(onNext: { [weak self] event in
            switch event {
            case .reloadTableView:
                self?.tableView.reloadData()
            case .reloadSections(let sections):
                self?.reloadTableView(sections: sections)
            }
        }).disposed(by: self.disposeBag)
    }

    private func reloadTableView(sections: [Int]) {
        let totalSections =  self.viewModel?.dataSource.numberOfSections() ?? 0
        guard totalSections > sections.max() ?? 0 else { return }
        let set = IndexSet.init(sections)
        tableView.beginUpdates()
        tableView.reloadSections(set, with: .automatic)
        tableView.endUpdates()
    }
    
//MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.dataSource.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.numberOfRows(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel?.dataSource.viewModel(at: indexPath) else { return UITableViewCell() }
        switch vm.getType() {
        case .search:
            let cell = UITableViewCell()
            cell.textLabel?.text = vm.text.value
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! RequisiteCell
            cell.setViewModel(vm)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vm = viewModel?.dataSource.viewModel(at: indexPath)
        switch vm?.getType() {
        case .search:
            return 44
        default:
            return 122
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vm = viewModel?.dataSource.viewModel(at: indexPath) {
            vm.handleTapAction()
        }
    }
}
