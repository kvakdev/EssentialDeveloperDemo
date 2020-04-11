//
//  PresentationType.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

enum PresentationType {
    case push
    case modal
    case modalPush
    case root
    case pushAfterRoot
    case replacePush(ReplacePushType)
}

enum ReplacePushType {
    case verification
}
