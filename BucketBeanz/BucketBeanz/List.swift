//
//  List.swift
//  BucketBeanz
//
//  Created by Rebeca Chavez on 12/10/22.
//

struct List {
  let title: String
  let isComplete: Bool
  
  init(title: String, isComplete: Bool = false) {
    self.title = title
    self.isComplete = isComplete
  }
  
  func completeToggled() -> List{
    return List(title: title, isComplete: !isComplete)
  }
}
