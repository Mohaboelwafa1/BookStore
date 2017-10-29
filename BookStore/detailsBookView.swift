//
//  detailsBookView.swift
//  BookStore
//
//  Created by mohamed hassan on 3/31/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreData


class detailsBookView : UIViewController {
    
     // MARK : Outlets and variables
    
    // outlets to objects in the storyboard
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    // book id wich will be used to fetch data from server
    var bookID : String? = nil
    
    // View model
    let viewModel = BookData_VM_Model()
    
    
    override func viewDidLoad() {
     
        
        if (getDataFromDB()) {
            // do nothing it is done
        }
        else {
        // Get data from Server
        self.viewModel.getBookDetails(flagSender: "BookDetailsFunction", bookID: self.bookID!, completionHandler: {
            
            (resultResponseModel) in
            
            let data = resultResponseModel as BookDataModel
            
            
            //assign the data to the labels
            self.titleLabel.text = data.title
            self.priceLabel.text = "$ \(data.price!)"
            self.authorLabel.text = "Author: \(data.author)"
            self.contentLabel.text = data.link
            
            
            
            // load image
            let picOperation : ImageLoader = ImageLoader()
            let url : String = (data.image)!
            picOperation.loadImageFromUrl(url: url, view: self.bookImage)
            
            
        })
        
    }
    }
    
    
    // back button function
    @IBAction func backButton(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    func getDataFromDB() -> Bool {
        
        // Get data From DB If exist
        
        let fetchRequest: NSFetchRequest<NewBook> = NewBook.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try (UIApplication.shared.delegate as! AppDelegate).getContext().fetch(fetchRequest)
            
            
            for book in searchResults as [NSManagedObject] {
                
                if ((book.value(forKey: "id")as! String)  == self.bookID) {
                    
                    
                    //assign the data to the labels
                    self.titleLabel.text = book.value(forKey: "title")as? String
                    self.priceLabel.text = "$ \(book.value(forKey: "price")as! Int)"
                    self.authorLabel.text = "Author: \(book.value(forKey: "author")as! String)"
                    self.contentLabel.text = (book.value(forKey: "link")as! String)
                    
                    
                    
                    // load image
                    let picOperation : ImageLoader = ImageLoader()
                    let url : String = (book.value(forKey: "image")as! String)
                    picOperation.loadImageFromUrl(url: url, view: self.bookImage)
                    
                    return true
                }
                
                
            }
        } catch {
            print("Error with request: \(error)")
            return false
        }
        

        return false
        
    }
    
}

