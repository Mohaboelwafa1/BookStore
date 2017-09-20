//
//  BackEndServent.swift
//  BookStore
//
//  Created by mohamed hassan on 9/18/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation

class BackEndServent {
    
    // MARK: - Domain
    
    // domain
    static var domainUrl  = "http://assignment.gae.golgek.mobi/api/v1/"


    
    // MARK: - authentication
    static var accountApi = "secure/"
    class func authenticate_Login()->String
    {
        let serviceName = "checkCredentials"
        let serviceURI = "\(domainUrl)\(accountApi)"
        print("service \(serviceName) url = \(serviceURI)")
        return serviceURI
        
    }
    
   
    
    // MARK: - get list of books
    static var itemsApi = "items/"
    class func listOfBooks()->String
    {
        let serviceName = "listOfIBooks"
        let serviceURI = "\(domainUrl)\(itemsApi)"
        print("service \(serviceName) url = \(serviceURI)")
        return serviceURI
        
    }
    
    
    
    // MARK: - book details
    
    class func BookDetails(bookID:String)->String
    {
        let serviceName = "book Details"
        let serviceURI = "\(domainUrl)\(itemsApi)\(bookID)"
        print("service \(serviceName) url = \(serviceURI)")
        return serviceURI
        
    }
    
    
}

