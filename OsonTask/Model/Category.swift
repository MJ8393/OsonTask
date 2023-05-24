//
//  Category.swift
//  OsonTask
//
//  Created by Mekhriddin Jumaev on 25/05/23.
//

import Foundation

struct Category {
    var id: Int?
    var parentId: Int?
    var childs: [Category]?
    
    init(id: Int, parentId: Int) {
        self.id = id
        self.parentId = parentId
    }
    
    mutating func addChild(_ child: Category) {
        if childs != nil {
            childs?.append(child)
        } else {
            childs = [child]
        }
    }
}


var categories: [Category] = [
    Category(id: 1, parentId: 0),
    Category(id: 2, parentId: 0),
    Category(id: 3, parentId: 0),
    
    Category(id: 10, parentId: 1),
    Category(id: 11, parentId: 1),
    Category(id: 12, parentId: 1),
    
    Category(id: 20, parentId: 2),
    Category(id: 21, parentId: 2),
    Category(id: 22, parentId: 2),
    
    Category(id: 30, parentId: 3),
    Category(id: 31, parentId: 3),
    Category(id: 32, parentId: 3),

    Category(id: 300, parentId: 30),
    Category(id: 310, parentId: 30),
    Category(id: 320, parentId: 30),
]
