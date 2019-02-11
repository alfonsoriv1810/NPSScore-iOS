//
//  KBaseModel.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/8/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import UIKit

class KBaseModel: NSObject {
    var rawValue:AnyObject? = nil
    
    override init() {
        super.init()
    }
    
    required init(objectToParse:AnyObject) {
        super.init()
        parseModelWithObject(modelObject: objectToParse)
    }
    
    func parseModelWithObject(modelObject:AnyObject) {
        self.rawValue = modelObject
    }
}
