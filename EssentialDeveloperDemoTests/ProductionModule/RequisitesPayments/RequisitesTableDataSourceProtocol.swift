//
//  RequisitesTableDataSourceProtocol.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/16/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

protocol RequisitesTableDataSourceProtocol {
    func numberOfRows(in section: Int) -> Int
    func numberOfSections() -> Int
    func viewModel(at indexPath: IndexPath) -> RequisitesCellViewModel?
    func getCellViewModel(type: RequisiteType) -> RequisitesCellViewModelProtocol?
}
