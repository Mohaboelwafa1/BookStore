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

class loginView : UIViewController  , UITextFieldDelegate{
    
    
    // MARK : Outlets and variables
    
    // outlets to objects from storyboard
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    // Credential json model
    var credentialJsonModel : CheckCredentialsModel!

    // Credential view model
    let viewModel = CheckCredentials_VM_Model()
    
    
    override func viewDidLoad() {
        
        // textFields delegate
        userNameTxt.delegate = self
        passWordTxt.delegate = self
        
    }
    
    
    
    @IBAction func loginTask(_ sender: Any) {
        
        
        // Check that the fields is not empty befor make the request
        if (self.validateCredentials() == true) {
            // show error message
            self.showAlert(message: "Please fill you data")
            return
        }
        
        
        // show loader
        loaderIndicator.startAnimating()
        
        // Unable user and pass txt and login btn
        self.EnableOutlets(flag: false)
        
        
        
        let user = userNameTxt.text//"usertest"
        let password = passWordTxt.text//"secret"
        
        self.viewModel.getRequestStatus(flagSender: "LoginFunction", userName: user!, passWord: password!, completionHandler: {
            
            (resultResponseModel) in
            
            self.credentialJsonModel = resultResponseModel
            
           
            
            guard self.credentialJsonModel.status == 200 else {
                
                self.showAlert(message: "Your credentials is not right , please try again")
                self.loaderIndicator.stopAnimating()
                
                // Unable user and pass txt and login btn
                self.EnableOutlets(flag: true)
                
                
                return
            }
            
            
            // Unable user and pass txt and login btn
            self.EnableOutlets(flag: true)
            
            
            // navigate to list screen
            self.loaderIndicator.stopAnimating()
            let listOfBooksView:listOfBooksView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listOfBooksView") as! listOfBooksView
            
            self.present(listOfBooksView, animated: false, completion: nil)
          
            
        })
       
        
    }

    
    // Enable and unable the outlets to prevent user interaction
    func EnableOutlets(flag : Bool) {
        
        self.userNameTxt.isEnabled = flag
        self.passWordTxt.isEnabled = flag
        self.loginButton.isEnabled = flag
        
    }

    
    
    // Check the fields if it is empty or not
    func validateCredentials() -> Bool {
        
        
        guard ((self.userNameTxt.text?.isEmpty)! || (self.passWordTxt.text?.isEmpty)!)  else {
        
            return false
        }
        
        return true
    }
    
    
    
    // Show alert message
    func showAlert(message : String) {
        
        
        
        let alert = UIAlertController(title: "Authentication", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "ok" , style: .default) { (_) in }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)

        
    }
    
    // delegation function for text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        
        // get the tag for each text field
        let tag = textField.tag
        
        switch tag {
        case 0:
            passWordTxt.becomeFirstResponder()
            return true
            
        case 1:
            
            self.view.endEditing(true)
            self.loginTask(self)
            return true
            
        default:
            return true
        }
        
        
    }
    

    
}





