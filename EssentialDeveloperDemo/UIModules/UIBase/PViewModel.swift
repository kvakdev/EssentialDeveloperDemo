//
//  PViewModel.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxSwift

protocol PViewModel: Deinitable, ErrorSupportable {
    var events: PublishSubject<BaseUIEvents> { get }
    /// Execute function when view did load
    func viewDidLoad()
    /// Execute function when view will appear
    func viewWillAppear()
    /// Execute function when view did appear
    func viewDidAppear()
    /// Execute function when view will disappear
    func viewWillDisappear()
    /// Execute function when view did disappear
    func viewDidDisappear()
}

extension PViewModel {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
