//
//  AuthenticationManager.swift
//  BookStore
//
//  Created by mohamed hassan on 9/17/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftSoup


class NetworkManager: NSObject {
    
    var dataWillPassed :AllBooksDataModel!
    
    // MARK: - initializer
    override init() {
        super.init()
        
        dataWillPassed = AllBooksDataModel(assigned: false)
        dataWillPassed.Books = []

    }
    
    
    // LogIn function
    func loginfunc (flagSender:String,userName:String, passWord:String,completionHandler: @escaping ( _ responseJsonModel:CheckCredentialsModel) -> Void) {
        
        
        
        Alamofire.request(BackEndServent.authenticate_Login())
            .authenticate(user: userName, password: passWord)
            .responseString { response in
                
                // get status code
                let result = CheckCredentialsModel(assigned: false)
                result.assigned = true
                result.status = response.response?.statusCode
                
                if(result.status == 200){
                    
                    // get Items API
                    do{
                        let html: String = response.result.value!
                        let doc: Document = try! SwiftSoup.parse(html)
                        let link: Element = try! doc.select("a").first()!
                        
                        let linkText: String = try! link.text();
                        SingletoneClass.sharedInstance.itemsAPI = linkText
                        
                        
                    }catch Exception.Error(let _, let message){
                        print(message)
                    }catch{
                        print("error")
                    }
                
                    
                    
                }
                
                completionHandler(result)
        }
        
        
        
    }
    
    
    
    
    
    // get list of books
    
    func getListOfBooksFunction (flagSender:String,count:Int, offset:Int,completionHandler: @escaping ( _ BooksJsonModel:AllBooksDataModel) -> Void) {
        
        // http request to the server to fetch the data
        
        let parameters: Parameters = ["count": count ,
                                      "offset":offset]
        
        Alamofire.request(BackEndServent.listOfBooks(),parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            if let JSON = response.result.value {
                
                // put the fetched data in the array that we declared
                let result = JSON as! NSArray
                if (result.count < 1){
                //completionHandler(self.dataWillPassed)
                return
                }
                for i in 0...result.count - 1 {
                    let newBook : BookDataModel = BookDataModel(assigned: false)
                    
                    newBook.id       = (result[i] as! NSDictionary)["id"] as! String
                    newBook.title    = (result[i] as! NSDictionary)["title"] as! String
                    newBook.price    = (result[i] as! NSDictionary)["price"] as! Int
                    newBook.link     = (result[i] as! NSDictionary)["link"] as! String
                    newBook.assigned = true
                    
                    self.dataWillPassed.Books.append(newBook)
                }
                
                completionHandler(self.dataWillPassed)
            }
            
            
        }
        
    }
    
    
    // get book details
    func getBookDetailsFunction (flagSender:String,bookID:String, completionHandler: @escaping ( _ responseJsonModel:BookDataModel) -> Void) {
        
        
        // fetching data from server by http request using alamofire
        Alamofire.request(BackEndServent.BookDetails(bookID: bookID)).responseJSON { response in
            if let JSON = response.result.value {
                
                // data comes from server
                let dataDic = JSON as! NSDictionary
                let data = BookDataModel(assigned: false)
                //assign the data to the labels
                data.title  = dataDic["title"] as? String
                data.price  = dataDic["price"] as? Int
                data.author = dataDic["author"] as? String
                data.link   = dataDic["link"] as? String
                data.image  = (dataDic["image"] as? String)!

                completionHandler(data)
                
            }
        }
        
        
        
    }
    
    
    
    
    
    
}


