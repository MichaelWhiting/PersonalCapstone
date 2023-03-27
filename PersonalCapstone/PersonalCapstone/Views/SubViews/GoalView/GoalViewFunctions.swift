//
//  GoalViewFunctions.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/22/23.
//

import Foundation

extension GoalView {
    // MARK: Functions
    func getDateStr(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: date)
    }
}
