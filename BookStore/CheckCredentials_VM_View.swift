//
//  CheckCredentials_VM_View.swift
//  BookStore
//
//  Created by mohamed hassan on 9/18/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation

protocol CheckCredentials_VM_View {
    
    
    var credentialsJsonModel  : Dynamic<CheckCredentialsModel> { get }
    
    
    
    // get request code
    func getRequestStatus(flagSender:String,userName:String, passWord:String,completionHandler: @escaping ( _ responseJsonModel:CheckCredentialsModel) -> Void)
    
}
