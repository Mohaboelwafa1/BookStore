//
//  CheckCredentials_VM_Model.swift
//  BookStore
//
//  Created by mohamed hassan on 9/18/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation


class CheckCredentials_VM_Model: NSObject , CheckCredentials_VM_View {
    
    var credentialsJsonModel  : Dynamic<CheckCredentialsModel>
    
    
    
    override init() {

        credentialsJsonModel = Dynamic<CheckCredentialsModel>(CheckCredentialsModel(assigned : false ));    
        super.init()
    }
    
    // get request status
    func getRequestStatus(flagSender:String,userName:String, passWord:String,completionHandler: @escaping ( _ responseJsonModel:CheckCredentialsModel) -> Void) {
        
        NetworkManager().loginfunc(flagSender:flagSender,userName:userName, passWord : passWord , completionHandler: {
            (ResponseModel) in
           
            self.credentialsJsonModel.value.status = ResponseModel.status
            self.credentialsJsonModel.value.assigned = true
            
            completionHandler(ResponseModel)
            
        })
    }
    
    
}
