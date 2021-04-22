//
//  TaskDetailViewController.swift
//  Task
//
//  Created by James Chun on 4/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    //MARK: - Properties
    //LANDING PAD
    var task: Task?
    var date: Date?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty,
              let notes = taskNotesTextView.text, !notes.isEmpty else { return }
                
        if let task = task {
            TaskController.sharedInstance.update(task: task, name: name, notes: notes, dueDate: date)
        } else {
            TaskController.sharedInstance.createTaskWith(name: name, notes: notes, dueDate: date)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let task = task else { return }
        
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }

}//End of class
