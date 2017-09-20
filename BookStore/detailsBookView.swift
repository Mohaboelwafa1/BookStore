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


class detailsBookView : UIViewController {
    
    
    // outlets to objects in the storyboard
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    // book id wich will be used to fetch data from server
    var bookID : String? = nil
    
    
    override func viewDidLoad() {
     
        
        let viewModel = BookData_VM_Model()
        
        
        viewModel.getBookDetails(flagSender: "BookDetailsFunction", bookID: self.bookID!, completionHandler: {
            
            (resultResponseModel) in
            
            let data = resultResponseModel as BookDataModel
            
            
            //assign the data to the labels
            self.titleLabel.text = data.title
            self.priceLabel.text = "$ \(data.price!)"
            self.authorLabel.text = data.author
            self.contentLabel.text = data.link
            
            
            
            // load image
            let picOperation : ImageLoader = ImageLoader()
            let url : String = (data.image)!
            picOperation.loadImageFromUrl(url: url, view: self.bookImage)
            
            
        })
        
    }
    
    
    // back button function
    @IBAction func backButton(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
}

