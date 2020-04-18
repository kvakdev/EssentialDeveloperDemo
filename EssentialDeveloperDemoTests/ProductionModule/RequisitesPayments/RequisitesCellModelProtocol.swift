//
//  RequisitesCellModelProtocol.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/18/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import Foundation
import RxCocoa

protocol RequisitesCellModelProtocol {
    var type: RequisiteType { get }
    var text: BehaviorRelay<String> { get }

    func validateProgress(_ string: String) throws
    func validateFinal(_ string: String) throws
}
