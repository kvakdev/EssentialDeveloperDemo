//
//  ViewSettable.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation

protocol ViewSettable {
    associatedtype ViewModel: PViewModel
    
    var viewModel: ViewModel? { get set }
}
