//
//  Item.swift
//  todoey
//
//  Created by Fiach Reid on 14/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var done : Bool = false
    @objc dynamic var title : String = ""
    @objc dynamic var dateCreated : Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
