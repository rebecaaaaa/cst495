//
//  CompletedItemsViewController.swift
//  BucketBeanz
//
//  Created by Rebeca Chavez on 12/7/22.
//

import UIKit

protocol CompletedItemsViewControllerDelegate: AnyObject {
    func CompletedItemsViewController(_ vc: CompletedItemsViewController, didSaveCompletedItems item: CompletedItems)
}

class CompletedItemsViewController: UIViewController {
    
    var item: CompletedItems?

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.text = item?.title
    }
    
    @IBOutlet weak var textField: UITextField!
    weak var delegate:CompletedItemsViewControllerDelegate?
    
    @IBAction func save(_ sender: Any) {
        
        let item = CompletedItems (title: textField.text!)
           delegate?.CompletedItemsViewController(self, didSaveCompletedItems: item)
    }

}
