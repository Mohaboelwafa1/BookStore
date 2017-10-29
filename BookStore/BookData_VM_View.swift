//
//  BookData_VM_View.swift
//  BookStore
//
//  Created by mohamed hassan on 9/17/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation

protocol BookData_VM_View {

    
    var bookJsonModel  : Dynamic<BookDataModel> { get }
    var AllBooksJsonModel  :  AllBooksDataModel { get }
    
    
    // get list of books
    func getListOfBooks(flagSender:String,count:Int, offset:Int,completionHandler: @escaping ( _ BooksJsonModel:AllBooksDataModel) -> Void)

    
    
    // get list of books
    func getBookDetails(flagSender:String,bookID:String, completionHandler: @escaping ( _ BookDetailJsonModel:BookDataModel) -> Void)
    
    
}

