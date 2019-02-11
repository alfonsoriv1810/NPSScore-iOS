//
//  KConstants.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/9/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import Foundation

//MARK:URLs
struct KURLs {
    static let principalURL = "http://demo.kinedu.com"
    static let biComplement = "/bi"
    
    //MARK: NPS Service
    static let npsService = "/nps"
}

//MARK:String message alerts
struct KStringsAlerts {
    static let connectionError = "An error has ocurred, please try again later."
}

//MARK:Request response values
struct KRequestResponseValues {
    static let data = "dataK"
    
    struct NPSResponseService {
        static let npsId = "id"
        static let npsValue = "nps"
        static let daysSinceSignUp = "days_since_signup"
        static let userPlan = "user_plan"
        static let activityViews = "activity_views"
        static let buildObject = "build"
        static let buildVersion = "version"
        static let buildReleaseDate = "release_date"
    }
}

//MARK:Keys to Handle data
struct KDictionaryDataKeys {
    static let npsResult = "nps"
    static let dateReleaseVersion = "dateReleaseVersion"
    static let buildVersion = "buildVersion"
    static let userPlanFreemium = "freemium"
    static let userPlanPremium = "premium"
}

//MARK:UI identifiers
struct KNavigationControllers {
    static let principalNavigationController = "principalNavigationController"
}

struct KViewControllers {
    static let npsBuildScoreViewController = "npsBuildScoreViewController"
    static let npsBuildDetailViewController = "KNpsBuildDetailViewController"
}

struct KStoryboards {
    static let mainStoryboard = "Main"
}

struct KCellsIdentifiers {
    static let npsValueCell = "KNpsValueCollectionViewCell"
}
