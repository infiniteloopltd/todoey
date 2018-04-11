//
//  ToDoItem.swift
//  todoey
//
//  Created by Fiach Reid on 11/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import Foundation

class ToDoItem
{
    var title : String = ""
    var done : Bool = false
    
    init(with: String)
    {
        title = with
    }
}
