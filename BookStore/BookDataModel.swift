//
//  BookModel.swift
//  BookStore
//
//  Created by mohamed hassan on 4/1/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import UIKit
import ObjectMapper


// Book model to create or manage book data
class BookDataModel: NSObject , Mappable {
    
    var id     : String!
    var title  : String!
    var price  : Int!
    var author : String!
    var image  : String!
    var link   : String!
    
    var assigned : Bool!
    
    init(assigned : Bool) {
        self.assigned = assigned
    }
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id      <- map["id"]
        title   <- map["title"]
        price   <- map["price"]
        author  <- map["author"]
        image   <- map["image"]
        link    <- map["link"]
        
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

