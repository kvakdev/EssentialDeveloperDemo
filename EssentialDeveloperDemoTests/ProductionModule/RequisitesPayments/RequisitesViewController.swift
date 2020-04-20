//
//  ViewController.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

class RequisitesViewController<T: RequisitesPaymentViewModelProtocol>: BaseVC<T>, UITableViewDataSource {
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        tableView.frame = self.view.bounds
        tableView.rowHeight = 122
        
        view.addSubview(tableView)
        
        tableView.register(RequisiteCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func setup(_ viewModel: T) {
        tableView.dataSource = self
        
        viewModel.events.subscribe(onNext: { [weak self] event in
            switch event {
            case .reloadTableView:
                self?.tableView.reloadData()
            case .reloadSections(let sections):
                guard viewModel.dataSource.numberOfSections() > sections.max() ?? 0 else { return }
                let set = IndexSet.init(sections)
                self?.tableView.reloadSections(set, with: .automatic)
            }
        }).disposed(by: self.disposeBag)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! RequisiteCell
        cell.setViewModel(vm)
        
        return cell
    }
}
