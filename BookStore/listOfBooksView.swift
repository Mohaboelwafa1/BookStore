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
import CoreData

class listOfBooksView : UIViewController  {
    
    
    
    // MARK : Outlets and variables
    
    // outlet to the table view from story board
    @IBOutlet weak var tabelList: UITableView!
    
    // the id of the book which will we use to navigate to the details page
    var bookID : String!
    
    // Books array
    var booksArray = AllBooksDataModel(assigned: false)
    
    
    // View Model
    let viewModel = BookData_VM_Model()
    
    // We will use it to enable pagination
    var lastOffSet = 0
    
    
    override func viewDidLoad() {
        
        // assign to the view model
        self.booksArray.Books = []
        
        // get book saved in DB if exist
        self.getBooks()
        
        // Check if there is network connection
        if Reachability.isConnectedToNetwork() == true {
            // Fetch data from server if the network is connected
            self.fetchData()
            
            
        }
        
        
    }
    
    
    // Get data from DB If there are ?
    func getBooks () {
        
        
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<NewBook> = NewBook.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try (UIApplication.shared.delegate as! AppDelegate).getContext().fetch(fetchRequest)
           
            
            
            for book in searchResults as [NSManagedObject] {
                
                
                let newBook : BookDataModel = BookDataModel(assigned: false)
                newBook.id = book.value(forKey: "id") as! String!
                newBook.title = book.value(forKey: "title") as! String!
                newBook.price = book.value(forKey: "price") as! Int!
                newBook.author = book.value(forKey: "author") as! String!
                newBook.image = book.value(forKey: "image") as! String!
                newBook.link = book.value(forKey: "link") as! String!
                
                // this will be added at the start of the list
                self.booksArray.Books.insert(newBook, at: 0)
                
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    
    
    
    // Refreshing table view to get data
    func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
            
            self.tabelList.reloadData()
            return
        })
    }
    
    
    
    
    // fetching the data from server
    func fetchData(){
        
        self.viewModel.getListOfBooks(flagSender: "GetAllBooksData", count: 20, offset: self.lastOffSet, completionHandler: {
            
            (Response) in
            
            self.booksArray.Books.append(contentsOf:  Response.Books)
            self.tabelList.reloadData()
            self.lastOffSet = self.lastOffSet  + 20
            
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
                
                
                // Add new book to DB
                (UIApplication.shared.delegate as! AppDelegate).storeBook(BookID: newBook.id , BookTitle: newBook.title, BookPrice: newBook.price, BookAuthor: newBook.author ?? " ", BookImage: newBook.image ?? " ", BookLink: newBook.link ?? " ")
                
                
                // this will be added at the start of the list
                self.booksArray.Books.insert(newBook, at: 0)
                
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


extension listOfBooksView : UITableViewDelegate , UITableViewDataSource {
    
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        
        
        let bookTitleLbl  = cell.viewWithTag(1) as! UILabel
        let bookPriceLbl  = cell.viewWithTag(2) as! UILabel
        
        let containerView = cell.viewWithTag(3)! as UIView
        containerView.layer.cornerRadius = 5
        
        // asign the data to the labels
        bookTitleLbl.text = self.booksArray.Books[indexPath.row].title
        bookPriceLbl.text = "$ \(self.booksArray.Books[indexPath.row].price!)"
        
        
        
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
            
            
            // Delete from DB
            let fetchRequest: NSFetchRequest<NewBook> = NewBook.fetchRequest()
            
            do {
                //go get the results
                let searchResults = try (UIApplication.shared.delegate as! AppDelegate).getContext().fetch(fetchRequest)
                
                
                for book in searchResults as [NSManagedObject] {
                    
                    let bookTitle = self.booksArray.Books[indexPath.row].title
                    
                    if (bookTitle  == (book.value(forKey: "title")as! String)) {
                        
                        (UIApplication.shared.delegate as! AppDelegate).getContext().delete(book as NSManagedObject)
                        
                        
                        //save the DB
                        do {
                            try (UIApplication.shared.delegate as! AppDelegate).getContext().save()
                            print("saved!")
                        } catch let error as NSError  {
                            print("Could not save \(error), \(error.userInfo)")
                        } catch {
                            
                        }
                        }
                    
                    
                }
            } catch {
                print("Error with request: \(error)")
            }
            
            
            self.booksArray.Books.remove(at: indexPath.row)
            self.tabelList.deleteRows(at: [index], with: .automatic)
            
            
            
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.booksArray.Books.count == indexPath.row + 1 {
            print("It is the last cell")
            self.fetchData()
        }
    }
    
    
    
    
}
