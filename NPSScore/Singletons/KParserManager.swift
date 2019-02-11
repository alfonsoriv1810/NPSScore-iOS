//
//  KParserManager.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/9/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import Foundation

protocol KParserDelegate: class {
    func didObtainModelsArrayFromObject(arrayParsed:AnyObject)
    func didObtainModelFromObject(objectParsed:AnyObject)
    func didFailedToParseFromObject(failedObject:AnyObject)
}

class KParserManager: NSObject {
    static let sharedInstance = KParserManager()
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
    weak var delegate:KParserDelegate?
    
    func willParseObject(object:AnyObject, senderDelegate:AnyObject) {
        self.delegate = senderDelegate as? KParserDelegate
        if object is Dictionary<AnyHashable,AnyObject> {
            if object[KRequestResponseValues.data] is Array<AnyObject> {
                self.delegate?.didObtainModelsArrayFromObject(arrayParsed: parseArrayObjects(arrayObjectsToParse: object[KRequestResponseValues.data] as AnyObject))
            } else {
                //TODO:Validate case here.
            }
        } else if object is Array<AnyObject> {
            self.delegate?.didObtainModelsArrayFromObject(arrayParsed: parseArrayObjects(arrayObjectsToParse: object))
        } else {
            self.delegate?.didFailedToParseFromObject(failedObject: object)
        }
    }
    
    private func stringClassFromString(_ className: String) -> AnyClass! {
        /// get namespace
        let appExecutableName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        
        /// get 'anyClass' with classname and namespace
        let classType: AnyClass = NSClassFromString("\(appExecutableName).\(className)")!;
        
        // return AnyClass!
        return classType;
    }
    
    //This method is prepared to receive a parameter and depending on the parameter it will change the class of the model.
    private func getClassStringNameToModel() -> String {
        var className:String = ""
        
        className = "KNpsModel"
        
        return className
    }
    
    private func parseObject(objectToParse:AnyObject) -> AnyObject {
        let classType = stringClassFromString(getClassStringNameToModel()) as! KBaseModel.Type
        let objectModel:KBaseModel = classType.init(objectToParse: objectToParse)
        return objectModel
    }
    
    private func parseArrayObjects(arrayObjectsToParse:AnyObject) -> AnyObject {
        let modelObjectsArray:NSMutableArray = NSMutableArray.init()
        
        for object in arrayObjectsToParse as! Array<Any> {
            let objecModel:AnyObject = parseObject(objectToParse: object as AnyObject)
            modelObjectsArray.add(objecModel)
        }
        
        return modelObjectsArray
    }
}
