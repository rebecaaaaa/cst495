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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkChanged(_ sender: Checkbox) {
        print("Checkbox \(sender.checked ? "Checked" : "Unchecked")")
    }
    
    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
    @IBSegueAction func completed_itemsVIewController(_ coder: NSCoder) -> CompletedItemsViewController? {
        let vc = BucketBeanz.CompletedItemsViewController(coder: coder)
            
            if let indexpath = tableView.indexPathForSelectedRow {
              let item = items[indexpath.row]
              vc?.item = item
            }
            
            vc?.delegate = self
            vc?.presentationController?.delegate = self
            
            return vc
          }
}

extension MyBucketBeanzViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
         let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
          
          let items = self.items[indexPath.row].completeToggled()
          self.items[indexPath.row] = items
          
          let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
          cell.set(checked: items.isComplete)
          
          complete(true)
          
          print("complete")
        }
        
        return UISwipeActionsConfiguration(actions: [action])
      }
      
      func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
      }
    
}

extension MyBucketBeanzViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        
        cell.delegate = self
        
        let item = items[indexPath.row]
        
        cell.set(title: item.title, checked: item.isComplete)
        
        return cell
      }
      
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          items.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .automatic)
        }
      }
      
      func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = items.remove(at: sourceIndexPath.row)
        items.insert(item, at: destinationIndexPath.row)
      }
}

extension MyBucketBeanzViewController: CheckTableViewCellDelegate {
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedState checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
          return
        }
        let item = items[indexPath.row]
        let newItem = CompletedItems(title: item.title, isComplete: checked)
        
        items[indexPath.row] = newItem
      }
}

extension MyBucketBeanzViewController: CompletedItemsViewControllerDelegate {
  
  func CompletedItemsViewController(_ vc: CompletedItemsViewController, didSaveCompletedItems item: CompletedItems) {

    dismiss(animated: true) {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        // update
        self.items[indexPath.row] = item
        self.tableView.reloadRows(at: [indexPath], with: .none)
      } else {
        // create
        self.items.append(item)
        self.tableView.insertRows(at: [IndexPath(row: self.items.count-1, section: 0)], with: .automatic)
      }
    }
  
  }
  
}

extension MyBucketBeanzViewController: UIAdaptivePresentationControllerDelegate {
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
}
