//
//  ViewController.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

protocol RequisitesPaymentViewModelProtocol: ViewModelProtocol {
    
}

class RequisitesViewController<T: RequisitesPaymentViewModelProtocol>: BaseVC<T> {

}

