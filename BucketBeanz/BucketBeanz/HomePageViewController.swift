//
//  HomePageViewController.swift
//  BucketBeanz
//
//  Created by Rebeca Chavez on 12/10/22.
//

import UIKit
import Parse

class HomePageViewController: UIViewController {
    
    var todos = [
        List(title: "Visit Paris."),
        List(title: "Graduate college."),
        List(title: "Receive job offer."),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBSegueAction func todoViewcontroller(_ coder: NSCoder, sender: Any?) -> ListViewController? {
        let vc = ListViewController(coder: coder)
            
            if let indexpath = tableView.indexPathForSelectedRow {
                let todo = todos[indexpath.row]
                vc?.todo = todo
            }
            
            vc?.delegate = self
            vc?.presentationController?.delegate = self
            
            return vc
        }
    
    
    @IBSegueAction func todoViewcontroller0(_ coder: NSCoder, sender: Any?) -> ListViewController? {
        let vc = ListViewController(coder: coder)
            
            if let indexpath = tableView.indexPathForSelectedRow {
                let todo = todos[indexpath.row]
                vc?.todo = todo
            }
            
            vc?.delegate = self
            vc?.presentationController?.delegate = self
            
            return vc
    }
    
    
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name:"Main", bundle: nil)
        
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
        
    }
    
}



extension HomePageViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
      
      let todo = self.todos[indexPath.row].completeToggled()
      self.todos[indexPath.row] = todo
      
      let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
      cell.set(checked: todo.isComplete)
      
      complete(true)
      
      print("complete")
    }
    
    return UISwipeActionsConfiguration(actions: [action])
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
}

extension HomePageViewController: UITableViewDataSource {

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
    
    cell.delegate = self
    
    let todo = todos[indexPath.row]
    
    cell.set(title: todo.title, checked: todo.isComplete)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      todos.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let todo = todos.remove(at: sourceIndexPath.row)
    todos.insert(todo, at: destinationIndexPath.row)
  }
  
}

extension HomePageViewController: CheckTableViewCellDelegate {
  
  func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedState checked: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    let todo = todos[indexPath.row]
    let newTodo = List(title: todo.title, isComplete: checked)
    
    todos[indexPath.row] = newTodo
  }
  
}

extension HomePageViewController: ListViewControllerDelegate {
    
  func todoViewController(_ vc: ListViewController, didSaveTodo todo: List) {
    
    
    
    dismiss(animated: true) {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        // update
        self.todos[indexPath.row] = todo
        self.tableView.reloadRows(at: [indexPath], with: .none)
      } else {
        // create
        self.todos.append(todo)
        self.tableView.insertRows(at: [IndexPath(row: self.todos.count-1, section: 0)], with: .automatic)
      }
    }
  
  }
  
}


extension HomePageViewController: UIAdaptivePresentationControllerDelegate {
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
}
