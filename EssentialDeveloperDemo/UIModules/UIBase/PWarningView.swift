//
//  PWarningView.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

protocol PSBWarningView: Deinitable {
    func updateTimer()
    func hideWarning()
    func setTitle(_ title: String)
    func setFont(_ font: UIFont)
    func setTextColor(_ color: UIColor)
    func setType(_ type: WarningType)
}
