//
//  CreateGoalFunctions.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/22/23.
//

import Foundation

extension CreateGoalView {
    func checkTextBoxes() {
        if !titleStr.isEmpty && !descriptionStr.isEmpty {
            if let goal {
                goal.title = titleStr
                goal.goalDescription = descriptionStr
                goal.progress = Double(progress)
                
                if goal.progress == 100 {
                    goal.isCompleted = true
                }
                
                try? moc.save()
                
                dismiss()
            } else {
                let newGoal = Goal(context: moc)
                newGoal.title = titleStr
                newGoal.goalDescription = descriptionStr
                newGoal.progress = Double(progress)
                newGoal.isCompleted = false
                newGoal.creationDate = Date()
                
                try? moc.save()
                
                dismiss()
            }
        }
    }
    
    func checkGoal() {
        if let goal {
            titleStr = goal.title ?? ""
            descriptionStr = goal.goalDescription ?? ""
            progress = Float(goal.progress)
        }
    }
}


