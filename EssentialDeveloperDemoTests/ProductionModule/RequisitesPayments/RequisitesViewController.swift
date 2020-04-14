//
//  ViewController.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit
import RxSwift

protocol RequisitesPaymentViewModelProtocol: ViewModelProtocol {
    
}

class RequisitesPaymentViewModel: BaseViewModel, RequisitesPaymentViewModelProtocol {
    
}

class RequisitesViewController<T: RequisitesPaymentViewModelProtocol>: BaseVC<T> {

}

