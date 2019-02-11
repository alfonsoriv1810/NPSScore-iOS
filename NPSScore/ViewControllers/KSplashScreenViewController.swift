//
//  KSplashScreenViewController.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/9/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import UIKit

class KSplashScreenViewController: KBaseViewController {

    //MARK:ViewController UI properties
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var tryAgainLabel: UILabel!
    
    //MARK:ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        markRequestToApi()
    }
    
    //MARK:ViewController parent methods
    override func didObtainModelsArrayFromObject(arrayParsed: AnyObject) {
        let arrayModel:NSArray = arrayParsed as! NSArray
        let mutableSetVersion:NSMutableSet = NSMutableSet.init()
        let resultBuildsArray:NSMutableArray = NSMutableArray.init()
        
        for model in arrayModel {
            let npsModel:KNpsModel = model as! KNpsModel
            if !mutableSetVersion.contains(npsModel.buildReleaseDateString) {
                let mutableDictionaryBuildInfo:NSMutableDictionary = NSMutableDictionary.init()
                let releasePredicate = NSPredicate(format: "buildReleaseDateString = '\(npsModel.buildReleaseDateString)'")
                let resultArray:NSArray = arrayModel.filtered(using: releasePredicate) as NSArray
                mutableDictionaryBuildInfo.setObject(resultArray, forKey: KDictionaryDataKeys.npsResult as NSCopying)
                mutableDictionaryBuildInfo.setObject(npsModel.buildReleaseDateString, forKey: KDictionaryDataKeys.dateReleaseVersion as NSCopying)
                mutableDictionaryBuildInfo.setObject(npsModel.buildVersion, forKey: KDictionaryDataKeys.buildVersion as NSCopying)
                let buildModel:KBuildModel = KBuildModel.init(objectToParse:mutableDictionaryBuildInfo)
                resultBuildsArray.add(buildModel)
                mutableSetVersion.add(npsModel.buildReleaseDateString)
            }
        }
        let descriptor = NSSortDescriptor(key: "releaseDate", ascending: false)
        KNPSSingleton.sharedInstance.buildsArray = resultBuildsArray.sortedArray(using: [descriptor]) as NSArray
        showBuildsController()
    }
    
    override func didFailedToParseFromObject(failedObject: AnyObject) {
        showErrorMessage()
    }
    
    override func showErrorMessage() {
        self.tryAgainLabel.isHidden = false
        self.tryAgainButton.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.tryAgainButton.alpha = 1
            self.tryAgainLabel.alpha = 1
        }
    }
    
    //MARK:ViewController UI methods
    @IBAction func didPressedTryAgainButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.tryAgainButton.alpha = 0
            self.tryAgainLabel.alpha = 0
        }) { (didFinish) in
            self.tryAgainLabel.isHidden = true
            self.tryAgainButton.isHidden = true
        }
        markRequestToApi()
    }
    
    func showBuildsController() {
        let currentStotyboard = UIStoryboard(name: KStoryboards.mainStoryboard, bundle: nil)
        let mainNavigationController = currentStotyboard.instantiateViewController(withIdentifier: KNavigationControllers.principalNavigationController) as! UINavigationController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    //MARK:ViewController request methods
    func markRequestToApi() {
        KRequestManager.sharedInstance.callRequest(url: KURLs.principalURL + KURLs.biComplement + KURLs.npsService, params: [:], methodType: .get, senderDelegate: self)
    }
}
