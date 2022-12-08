//
//  CompletedItems.swift
//  BucketBeanz
//
//  Created by Rebeca Chavez on 12/7/22.
//

import Foundation

struct CompletedItems {
    let title: String
    let isComplete: Bool
    
    init(title: String, isComplete: Bool = false) {
       self.title = title
       self.isComplete = isComplete
     }
     
     func completeToggled() -> CompletedItems {
       return CompletedItems (title: title, isComplete: !isComplete)
     }
}
