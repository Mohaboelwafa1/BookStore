//
//  checkCredentialsModel.swift
//  BookStore
//
//  Created by mohamed hassan on 9/18/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class CheckCredentialsModel: NSObject , Mappable {
    
    var status   : Int!
    var assigned : Bool!
    
    init(assigned : Bool) {
       
    }
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        assigned = true
    }
    func NotNullCheck(tempObject : Map )-> String{
        
        if tempObject.value() != nil {
            
            return ""
        }
        else{
            
            return tempObject.value()!
            
        }
    }
    
}

