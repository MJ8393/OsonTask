//
//  MainViewModel.swift
//  OsonTask
//
//  Created by Mekhriddin Jumaev on 25/05/23.
//

import Foundation

class MainViewModel {
    
    // MARK: Properties

    var orderedCategoriesDidChange: (() -> Void)?
    
    var orderedCategories: [Category]? {
        didSet {
            orderedCategoriesDidChange?()
        }
    }
    
    // Category Tree Construction Algorithm
    
    func makeTree(list: [Category]) {
        var categoryMap = [Int: Category]()
        
        // Build a map of categories using their ids as keys
        for category in list {
            categoryMap[category.id ?? 0] = category
        }

        // Build Tree Hierarchy
        for category in list {
            if let parentId = category.parentId, var parent = categoryMap[parentId] {
                parent.addChild(category)
                categoryMap[parentId] = parent
            }
        }
        
        // Filter Root Categories
        orderedCategories = Array(categoryMap.values.filter { $0.parentId == 0 })
    }
    
}
