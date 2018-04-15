//
//  Category.swift
//  todoey
//
//  Created by Fiach Reid on 14/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colour : String = UIColor.randomFlat.hexValue()
    let items = List<Item>()
}
