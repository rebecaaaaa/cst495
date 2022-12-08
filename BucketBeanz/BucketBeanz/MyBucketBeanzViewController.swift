//
//  MyBucketBeanzViewController.swift
//  BucketBeanz
//
//  Created by Rebeca Chavez on 12/7/22.
//

import UIKit

class MyBucketBeanzViewController: UIViewController {
    
    var items = [
        CompletedItems(title: "Visit Paris"),
        CompletedItems(title: "Visit London"),
        CompletedItems(title: "Visit Mumbai")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func checkChanged(_ sender: Checkbox) {
        print("Checkbox \(sender.checked ? "Checked" : "Unchecked")")
    }
}

extension MyBucketBeanzViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        
        cell.delegate = self
        
        let items = items[indexPath.row]
        
        print(indexPath)
        
        cell.set(title: items.title, checked: items.isComplete)
        
        return cell
    }
}

extension MyBucketBeanzViewController: CheckTableViewCellDelegate {
    func checkTableViewCell(_ cell: CheckTableViewCell, didChagneCheckedState checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let items = items[indexPath.row]
        let newItems = CompletedItems(title: items.title, isComplete: checked)
        items[indexPath.row] = newItems
    }
}
