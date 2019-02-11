//
//  KRequestMAnager.swift
//  NPSScore
//
//  Created by Alfonso Rivera Cortés on 2/9/19.
//  Copyright © 2019 FARC. All rights reserved.
//

import Alamofire

protocol KRequestResponseManagerDelegate: class {
    func didSuccesResponse(responseObject:AnyObject)
    func didFailedResponse(responseObject:AnyObject)
}

class KRequestManager: NSObject {
    static let sharedInstance = KRequestManager()
    weak var delegate:KRequestResponseManagerDelegate?
    
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
    public func callRequest(url:String, params:[String:Any], methodType:HTTPMethod, senderDelegate:AnyObject) {
        self.delegate = senderDelegate as? KRequestResponseManagerDelegate
        Alamofire.request(url, method: methodType, parameters: params).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    self.delegate?.didSuccesResponse(responseObject: response.result.value as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error as Any)
                self.delegate?.didFailedResponse(responseObject: response.result.error as AnyObject)
                break
            }
        }
    }
}
