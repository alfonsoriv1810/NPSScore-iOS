//
//  KBaseViewController.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/8/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import UIKit

class KBaseViewController: UIViewController, KRequestResponseManagerDelegate, KParserDelegate {
    //MARK: ViewController life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    //MARK:ViewController behavior methods
    func showErrorMessage() {
        //TODO:Implement error message in child class.
    }
    
    func setUpNavigationBar() {
        if self.navigationController != nil {
            let yourBackImage = UIImage(named: "arrow_left")
            self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }
    
    //MARK: KRequestResponseManagerDelegate methods
    func didSuccesResponse(responseObject: AnyObject) {
        //TODO:Implement parser and dismiss loadingView
        KParserManager.sharedInstance.willParseObject(object: responseObject, senderDelegate: self)
    }
    
    func didFailedResponse(responseObject: AnyObject) {
        showErrorMessage()
    }
    
    //MARK:KParserDelegate Methods
    func didObtainModelsArrayFromObject(arrayParsed: AnyObject) {
        //TODO:Override this method in child class when need it
    }
    
    func didObtainModelFromObject(objectParsed: AnyObject) {
        //TODO:Override this method in child class when need it
    }
    
    func didFailedToParseFromObject(failedObject: AnyObject) {
        showErrorMessage()
    }
}
