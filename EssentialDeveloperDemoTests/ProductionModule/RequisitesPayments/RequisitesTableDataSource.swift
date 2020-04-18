//
//  RequisitesTableDataSource.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/16/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation


class RequisitesTableDataSource: BaseViewModel, RequisitesTableDataSourceProtocol {
    private var sections: [RequisitesSectionViewModel] = []
    var mode: RequisitesPaymentViewModel.Mode = .all
    
    func setSections(_ sections: [RequisitesSectionViewModel]) {
        self.sections = sections
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard section < sections.count else { return 0 }
        let neededSection = sections[section]
        
        switch mode {
        case .all:
            return neededSection.viewModels.count
        case .search(let type):
            return neededSection.viewModels.filter { $0.getType() == type }.count
        }
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