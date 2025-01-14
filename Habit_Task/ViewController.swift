//
//  ViewController.swift
//  Habit_Task
//
//  Created by Mohamed Elkazzaz on 14/01/2025.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var habitTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        statusLabel.isHidden = true
        completeButton.layer.cornerRadius = completeButton.frame.height / 2
    }
    @IBAction func completedButtonPressed(_ sender: UIButton) {
        guard let habitName = habitTextField.text, !habitName.isEmpty else {
            statusLabel.isHidden = false
            statusLabel.text = "Please enter a habit name!"
            statusLabel.textColor = .systemRed
            return
        }
        
        statusLabel.isHidden = false
        saveHabitToFirebase(habitName: habitName)
        statusLabel.text = "You completed '\(habitName)' for today!"
        statusLabel.textColor = .systemGreen
        
        habitTextField.text = ""
    }

    private func saveHabitToFirebase(habitName: String) {
            let ref = Database.database().reference()
            let habitData: [String: Any] = [
                "habitName": habitName,
                "isCompleted": true,
                "date": Date().description
            ]
            ref.child("habits").childByAutoId().setValue(habitData)
        }
}

