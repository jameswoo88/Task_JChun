//
//  TaskListTableViewController.swift
//  Task
//
//  Created by James Chun on 4/21/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TaskController.sharedInstance.loadFromPersistenceStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.task = TaskController.sharedInstance.tasks[indexPath.row]
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.sharedInstance.tasks[indexPath.row]
            TaskController.sharedInstance.delete(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 16
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "toTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? TaskDetailViewController else { return }
            
            let taskToSend = TaskController.sharedInstance.tasks[indexPath.row]
            destinationVC.task = taskToSend
        }
    }

}//End of class

extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(for sender: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        sender.task = TaskController.sharedInstance.tasks[indexPath.row]

        if let task = sender.task {
            TaskController.sharedInstance.toggleIsComplete(task: task)
        }

        sender.updateViews()
    }

}//End of extension

