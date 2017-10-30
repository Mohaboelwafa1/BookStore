//
//  SingletoneClass.swift
//  BookStore
//
//  Created by mohamed hassan on 10/29/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
class SingletoneClass: NSObject {
    static let sharedInstance = SingletoneClass()
    // Items API that we will get from login API
    var itemsAPI : String = ""

}
