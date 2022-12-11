//
//  ListViewController.swift
//  BucketBeanz
//
//  Created by Rebeca Chavez on 12/10/22.
//

import UIKit
import Parse

protocol ListViewControllerDelegate: AnyObject {
  func todoViewController(_ vc: ListViewController, didSaveTodo todo: List)
}

class ListViewController: UIViewController {
  
  @IBOutlet weak var textfield: UITextField!
  var todo: List?
  
  weak var delegate: ListViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    textfield.text = todo?.title
  }
    
  @IBAction func save(_ sender: Any) {
    let todo = List(title: textfield.text!)
    delegate?.todoViewController(self, didSaveTodo: todo)
  }
  
}
