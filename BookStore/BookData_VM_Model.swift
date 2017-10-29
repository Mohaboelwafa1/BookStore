//
//  BookData_VM_Model.swift
//  BookStore
//
//  Created by mohamed hassan on 9/17/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import UIKit

class BookData_VM_Model : NSObject, BookData_VM_View {
    
    var bookJsonModel  : Dynamic<BookDataModel>
    var AllBooksJsonModel  : AllBooksDataModel
    

    
    // MARK: Init
    override init() {
       
        bookJsonModel     = Dynamic<BookDataModel>(BookDataModel(assigned : false ));
        
        AllBooksJsonModel  = AllBooksDataModel(assigned: false)
        AllBooksJsonModel.Books = []
        
        super.init()
    }
    
    
    
    // get list of books
    func getListOfBooks(flagSender:String,count:Int, offset:Int,completionHandler: @escaping ( _ responseJsonModel:AllBooksDataModel) -> Void) {
        
        // access data access layer to get the data from api
        NetworkManager().getListOfBooksFunction(flagSender: "GetListOfBooks", count: count, offset: offset, completionHandler: {
        
            
            (ResponseModel) in
            
            
            let arr = ResponseModel as AllBooksDataModel
            self.AllBooksJsonModel = arr
            completionHandler(self.AllBooksJsonModel)
            
            
        })
    }
    
    
    
    // get list of books
    func getBookDetails(flagSender:String,bookID:String, completionHandler: @escaping ( _ responseJsonModel:BookDataModel) -> Void) {
        
        // access data access layer to get the data from api
        
        
        NetworkManager().getBookDetailsFunction(flagSender: "BookDetailsFunction", bookID: bookID, completionHandler: {
        
            (bookDataJsonModel) in
            
            completionHandler(bookDataJsonModel as BookDataModel)
        
        })
    }
    
    
    
}
