//
//  AppDelegate.swift
//  BookStore
//
//  Created by mohamed hassan on 3/31/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    
    // MARK: - Core Data stack
    
    // Get context
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    // Store a new book
    func storeBook (BookID: String, BookTitle: String, BookPrice: Int, BookAuthor: String, BookImage: String, BookLink: String) {
        let context = getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "NewBook", in: context)
        
        let book = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        book.setValue(BookID, forKey: "id")
        book.setValue(BookTitle, forKey: "title")
        book.setValue(BookPrice, forKey: "price")
        book.setValue(BookAuthor, forKey: "author")
        book.setValue(BookImage, forKey: "image")
        book.setValue(BookLink, forKey: "link")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    
    // Get data
    func getBooks () {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<NewBook> = NewBook.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for book in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                print("book title \(book.value(forKey: "title"))")
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    
    
    
    //Delete values from User Info table
//    func deleteUserInfoData() {
//        let context = getContext()
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewBook")
//        fetchRequest.includesPropertyValues = false // Only fetch the managedObjectID (not the full object structure)
//        if let fetchResults = context.executeFetchRequest(fetchRequest, error: nil) as? [NewBook] {
//            for result in fetchResults {
//                managedContext.deleteObject(result)
//            }
//        }
//        var err: NSError?
//        if !context.save(&err) {
//            print("User Info deleteData - Error : \(err!.localizedDescription)")
//            abort()
//        } else {
//            print("User Info deleteData - Success")
//        }
//    }
//    
//    
    
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "NewBookDBModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    
}

