//
//  BaseVC.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

class BaseVC<T: ViewModelProtocol>: UIViewController {
    var viewModel: T?
    
}
