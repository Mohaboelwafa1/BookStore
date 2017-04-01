//
//  listOfBooksView.swift
//  BookStore
//
//  Created by mohamed hassan on 3/31/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class listOfBooksView : UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var tabelList: UITableView!
    
    
    var booksList : NSArray!
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {

        //print("@@@@\(self.booksList)")
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.booksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")

        let rowTitle = (self.booksList[indexPath.row] as! NSDictionary)["title"] as! String
        let rowPrice = (self.booksList[indexPath.row] as! NSDictionary)["price"] as! Int
        
        cell.textLabel?.text = rowTitle
        cell.detailTextLabel?.text = "$ \(rowPrice)"
     
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsBookView : detailsBookView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsBookView") as! detailsBookView
        self.present(detailsBookView, animated: false, completion: nil)
        
        
        
        
    }
    
    
    
    
 
    
    

    
    

    
    
    
}
