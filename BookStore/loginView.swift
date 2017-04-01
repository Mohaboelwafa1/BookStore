//
//  ViewController.swift
//  BookStore
//
//  Created by mohamed hassan on 3/31/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class loginView : UIViewController {
    
    // list ob books as an array
    var booksListAsAnArray : NSArray!
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Request data from server
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginTask(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork() == false {
            
            let alert = UIAlertView(title: "Error", message: "Please make sure of your internet connection", delegate: nil, cancelButtonTitle: "OK")
            alert.alertViewStyle = .default
            alert.show()
            return
            
        }
        
        // validate the user first
        if (userNameTxt.text == "usertest" && passWordTxt.text == "secret") {
            
            // Request data from server
            fetchData()
            
            
            // navigate to the book list page
            let listOfBooksView:listOfBooksView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listOfBooksView") as! listOfBooksView
            listOfBooksView.booksList = self.booksListAsAnArray
            self.present(listOfBooksView, animated: false, completion: nil)
            
            
        }
        else {
            
            
            let alert = UIAlertView(title: "Error", message: "Please make sure of username and password", delegate: nil, cancelButtonTitle: "OK")
            alert.alertViewStyle = .default
            alert.show()
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    // fetching the data from server
    func fetchData(){
        
        if Reachability.isConnectedToNetwork() == false {
            
            let alert = UIAlertView(title: "Error", message: "Please make sure of your internet connection", delegate: nil, cancelButtonTitle: "OK")
            alert.alertViewStyle = .default
            alert.show()
            return
            
        }
            
        else {
            
            
            
            Alamofire.request("http://assignment.gae.golgek.mobi/api/v1/items").responseJSON { response in
                if let JSON = response.result.value {
                    
                    self.booksListAsAnArray = JSON as! NSArray
                    
                    
                    
                    
                    
                }
            }
            
            
            
            
        }
    }
    
    
    
    
    
    
    
    
}

