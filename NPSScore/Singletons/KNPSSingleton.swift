//
//  KNPSSingleton.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/10/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import Foundation

class KNPSSingleton: NSObject {
    static let sharedInstance = KNPSSingleton()
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
    var buildsArray:NSArray? = nil
}
