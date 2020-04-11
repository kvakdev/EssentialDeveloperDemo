//
//  BaseUIEvents.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

enum BaseUIEvents {
    case back
    case backToRoot
    case dismiss(animate: Bool, completion: (() -> Void)?)
    case reload
    case localize
    case loading(Loading)
    case tableView(TableViewEvents)
    
    case hideKeyboard
    case showKeyboard(index: Int)
    case disableInteractions(Bool)
}

enum Loading {
    case start
    case stop
}

enum TableViewEvents {
    // Reload
    case reload
    case reloadSections(_ sections: IndexSet)
    case reloadSectionsWithoutAnimation(_ sections: IndexSet)
    case reloadRows([IndexPath])
    // Scroll
    case scrollToRow(IndexPath)
    // Insert
    case insertSections(IndexSet)
    case insertRows([IndexPath])
    // Delete
    case deleteSections(IndexSet)
    case deleteRows([IndexPath])
    // Move
    case moveSection(from: Int, to: Int)
    case moveRow(from: IndexPath, to: IndexPath)
    // Select / Deselect
    case selectRow(IndexPath)
    case deselectRow(IndexPath)
    case setEditing(_ editing: Bool, animated: Bool)
    // update
    case update
}

