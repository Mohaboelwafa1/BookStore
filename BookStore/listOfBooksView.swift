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
    
    // outlet to the table view from story board
    @IBOutlet weak var tabelList: UITableView!
    
    // Refresh control to get new data if exists
    var refreshControl = UIRefreshControl()
    
    var bookID : String!        // the id of the book which will we use to navigate to the details page
    var booksArray = AllBooksDataModel(assigned: false)

    
    
    
    override func viewDidLoad() {
        
        // UI refresh control (Pull to refresh the grid)
        refreshControl.addTarget(self, action: #selector(self.fetchData), for: .valueChanged)
        self.tabelList!.addSubview(refreshControl)
        self.tabelList!.alwaysBounceVertical = true;
        
        // assign to the view model
        self.booksArray.Books = []
        
        // Check if there is network connection
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            self.refreshControl.beginRefreshing()
            // Fetch data from server if the network is connected
            self.fetchData()
            
            
        }
        
        
    }
    // number of sections in the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // number of elements or rows  in the table are the count of the array of books data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.booksArray.Books.count
    }
    
    // draw each table cell with data from the array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // declare the cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        
        
        // asign the data to the labels
        cell.textLabel?.text = self.booksArray.Books[indexPath.row].title
        cell.detailTextLabel?.text = "$ \(self.booksArray.Books[indexPath.row].price!)"
        
        return cell
        
    }
    
    
    // when user select a row , id of the row will be used to pass it to the details data page to get its content
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.bookID = self.booksArray.Books[indexPath.row].id as String
        
        let detailsView : detailsBookView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsBookView") as! detailsBookView
        
        detailsView.bookID = self.bookID
        self.present(detailsView, animated: false, completion: nil)
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            let index = IndexPath(row: indexPath.row , section: 0)
            tableView.deselectRow(at: index, animated: true)
            
            self.booksArray.Books.remove(at: indexPath.row)
            self.tabelList.deleteRows(at: [index], with: .automatic)
            tabelList.reloadData()
            
        }
    }
    
    
    
    
    
    // Refreshing table view to get data
    func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
            
            self.tabelList.reloadData()
            self.refreshControl.endRefreshing()
            return
        })
    }
    
    
    

    // fetching the data from server
    func fetchData(){
        
        
        
        let viewModel = BookData_VM_Model()
        viewModel.getListOfBooks(flagSender: "GetAllBooksData", count: 10, offSet: 0, completionHandler: {
            
            (Response) in
            
            self.booksArray = Response as AllBooksDataModel
            self.tabelList.reloadData()
            self.refreshControl.endRefreshing()
        })
        
        

    }
    
    
    
    // back button function
    @IBAction func backButtonFunction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    // add new book
    @IBAction func addNewBook(_ sender: Any) {
        
        
        
        let newBook : BookDataModel = BookDataModel(assigned: false)
        
        
        // 1. declare text fields
        var idTextField: UITextField?
        var titleTextField: UITextField?
        var priceTextField: UITextField?
        var authorTextField: UITextField?
        var imageTextField: UITextField?
        var linkTextField: UITextField?
        
        // 2.
        let alertController = UIAlertController(
            title: "Add new book",
            message: "Please enter book data",
            preferredStyle: UIAlertControllerStyle.alert)
        
        // 3.
        let addNewBookAction = UIAlertAction(
        title: "Add new book", style: UIAlertActionStyle.default) {
            (action) -> Void in
            
            if let id = idTextField?.text {
                
                newBook.id = id
            } else {
                print("No id entered")
            }
            
            if let title = titleTextField?.text {
                
                newBook.title = title
            } else {
                print("No title entered")
            }
            
            if let price = Int((priceTextField?.text)!) {
                
                newBook.price = price
            } else {
                print("No price entered \(priceTextField?.text)")
                newBook.price = 0
            }
            
            if let author = authorTextField?.text {
                
                newBook.author = author
            } else {
                print("No author entered")
            }
            
            if let image = imageTextField?.text {
                
                newBook.image = image
            } else {
                print("No image entered")
            }
            
            if let link = linkTextField?.text {
                
                newBook.link = link
            } else {
                
            }
            
            
            
            
            
            
            guard newBook.id.isEmpty , newBook.title.isEmpty , newBook.price == 0  else {
                
                // this will be added at the end of the list
                self.booksArray.Books.append(newBook)
                self.tabelList.reloadData()
                return
                
            }
            
            let alert = UIAlertView(title: "Error", message: "Please insert book id , title and price", delegate: nil, cancelButtonTitle: "OK")
            alert.alertViewStyle = .default
            alert.show()
            
        }
        
        
        // 4.
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            
        }
        
        
        
        
        
        // 5.
        alertController.addTextField {
            (txtid) -> Void in
            idTextField = txtid
            idTextField?.keyboardType = .numberPad
            idTextField?.tag = 0
            idTextField!.placeholder = "<Book id here>"
        }
        
        alertController.addTextField {
            (txttitle) -> Void in
            titleTextField = txttitle
            idTextField?.tag = 1
            titleTextField!.placeholder = "<Book title here>"
        }
        
        alertController.addTextField {
            (txtprice) -> Void in
            priceTextField = txtprice
            priceTextField?.keyboardType = .numberPad
            idTextField?.tag = 2
            priceTextField!.placeholder = "<Book price here>"
        }
        
        alertController.addTextField {
            (txtauthor) -> Void in
            authorTextField = txtauthor
            idTextField?.tag = 3
            authorTextField!.placeholder = "<Book author here>"
        }
        
        alertController.addTextField {
            (txtimage) -> Void in
            imageTextField = txtimage
            idTextField?.tag = 4
            imageTextField!.placeholder = "<Book image here>"
        }
        
        alertController.addTextField {
            (txtlink) -> Void in
            linkTextField = txtlink
            idTextField?.tag = 5
            linkTextField!.placeholder = "<Book link here>"
        }
        
        
        // 6.
        alertController.addAction(addNewBookAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
}
