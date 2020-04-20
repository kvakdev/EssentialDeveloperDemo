//
//  BaseVC.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/13/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit
import RxSwift

class BaseVC<T: ViewModelProtocol>: UIViewController {
    var viewModel: T? {
        didSet {
            guard let vm = viewModel else { return }
            setup(vm)
        }
    }
    let disposeBag = DisposeBag()
    
    func setup(_ viewModel: T) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel?.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel?.viewDidDisappear()
    }
}
