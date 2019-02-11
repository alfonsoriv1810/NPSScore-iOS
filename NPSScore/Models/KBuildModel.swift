//
//  KBuildModel.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/10/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import UIKit

class KBuildModel: KBaseModel {
    public var version:String = ""
    public var freemiumUsers:NSArray? = nil
    public var premiumUsers:NSArray? = nil
    public var allUsers:NSArray? = nil
    public var releaseDate:Date? = nil
    
    override func parseModelWithObject(modelObject: AnyObject) {
        if let versionString = modelObject[KDictionaryDataKeys.buildVersion] as? String {
            self.version = versionString
        }
        
        if let buildReleaseDateService = modelObject[KDictionaryDataKeys.dateReleaseVersion] as? String {
            let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            self.releaseDate = dateFormatter.date(from: buildReleaseDateService)
        }
        
        if (modelObject[KDictionaryDataKeys.npsResult] as? NSArray) != nil {
            self.allUsers = (modelObject[KDictionaryDataKeys.npsResult] as! NSArray)
            let freemiumPredicate = NSPredicate(format: "userPlan = '\(KDictionaryDataKeys.userPlanFreemium)'")
            self.freemiumUsers = self.allUsers!.filtered(using: freemiumPredicate) as NSArray
            
            let premiumPredicate = NSPredicate(format: "userPlan = '\(KDictionaryDataKeys.userPlanPremium)'")
            self.premiumUsers = self.allUsers!.filtered(using: premiumPredicate) as NSArray
        } else {
            self.allUsers = NSArray.init()
            self.freemiumUsers = NSArray.init()
            self.premiumUsers = NSArray.init()
        }
    }
}
