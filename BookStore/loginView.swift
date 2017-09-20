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
    
    
    
    // outlets to objects from storyboard
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    // A flag to determine if the user permitted to login or not
    var autherizedFlag : Bool = false    
    var credentialJsonModel : CheckCredentialsModel!

    override func viewDidLoad() {
        
        // textFields delegate
        userNameTxt.delegate = self
        passWordTxt.delegate = self
        
    }
    
    
    
    @IBAction func loginTask(_ sender: Any) {
        
        loaderIndicator.startAnimating()
        
        let viewModel = CheckCredentials_VM_Model()
        
        let user = userNameTxt.text//"usertest"
        let password = passWordTxt.text//"secret"
        
        viewModel.getRequestStatus(flagSender: "LoginFunction", userName: user!, passWord: password!, completionHandler: {
            
            (resultResponseModel) in
            
            self.credentialJsonModel = resultResponseModel
            
            
            guard self.credentialJsonModel.status == 200 else {
                
                let alert = UIAlertView(title: "Authentication", message: "Your credentials is not right , please try afain", delegate: nil, cancelButtonTitle: "OK")
                alert.alertViewStyle = .default
                alert.show()
                self.loaderIndicator.stopAnimating()
                
                return
            }
            
            
            // navigate to list screen
            
            print("We are navigating you to the next screen...")
            self.loaderIndicator.stopAnimating()
            let listOfBooksView:listOfBooksView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listOfBooksView") as! listOfBooksView
            
            self.present(listOfBooksView, animated: false, completion: nil)
            
            
            
            
            
        })
       
        
    }

    

    
    // delegation function for text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        
        // get the tag for each text field
        let tag = textField.tag
        
        switch tag {
        case 0:
            passWordTxt.becomeFirstResponder()
            //self.view.endEditing(true)
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





