//
//  TaskTableViewCell.swift
//  Task
//
//  Created by James Chun on 4/21/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(for sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    //MARK: - Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TaskCompletionDelegate?

    //MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(for: self)
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let task = task else { return }
        
        taskNameLabel.text = task.name
        completionButton.backgroundColor = task.isComplete ? #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        //Update UIImage on main thread
        DispatchQueue.main.async {
            self.completionButton.imageView?.image = task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete")
        }
    }
    
}//End of class
