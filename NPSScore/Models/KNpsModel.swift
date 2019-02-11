//
//  KNpsModel.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/9/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import UIKit

class KNpsModel: KBaseModel {
    var npsId:Int = 0
    var npsValue:Int =  0
    var daysSinceSignUp:Int = 0
    var userPlan:String = ""
    var activityViews:Int = 0
    var buildObject:AnyObject? = nil
    var buildVersion:String = ""
    var buildReleaseDate:Date? = nil
    var buildReleaseDateString:String = ""
    
    override func parseModelWithObject(modelObject: AnyObject) {
        super.parseModelWithObject(modelObject: modelObject)
        
        if let npsIdService = modelObject[KRequestResponseValues.NPSResponseService.npsId] as? Int {
            self.npsId = npsIdService
        }
        
        if let npsValueService = modelObject[KRequestResponseValues.NPSResponseService.npsValue] as? Int {
            self.npsValue = npsValueService
        }
        
        if let daysSinceSingUpService = modelObject[KRequestResponseValues.NPSResponseService.daysSinceSignUp] as? Int {
            self.daysSinceSignUp = daysSinceSingUpService
        }
        
        if let userPlanService = modelObject[KRequestResponseValues.NPSResponseService.userPlan] as? String {
            self.userPlan = userPlanService
        }
        
        if let activityViewsService = modelObject[KRequestResponseValues.NPSResponseService.activityViews] as? Int {
            self.activityViews = activityViewsService
        }
        
        if let buildObjectService = modelObject[KRequestResponseValues.NPSResponseService.buildObject] as? [String:Any] {
            self.buildObject = buildObjectService as AnyObject
            if let buildVersionService = buildObjectService[KRequestResponseValues.NPSResponseService.buildVersion] as? String {
                self.buildVersion = buildVersionService
            }
            
            if let buildReleaseDateService = buildObjectService[KRequestResponseValues.NPSResponseService.buildReleaseDate] as? String {
                self.buildReleaseDateString = buildReleaseDateService
                let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = dateFormat
                self.buildReleaseDate = dateFormatter.date(from: self.buildReleaseDateString)
            }
        }
    }
}
