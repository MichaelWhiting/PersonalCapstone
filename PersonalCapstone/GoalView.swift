//
//  GoalView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/9/23.
//

import SwiftUI

struct GoalView: View {
    let goal: Goal

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 5) {
                Text("\(goal.title)")
                    .font(.title3)
                    .bold()
                Spacer()
                Text(getDateStr(date: goal.creationDate))
            }
            HStack {
                Text(goal.description)
                Spacer()
                Text("\(Int(goal.progress))%")
            }
        }
    }
}

// MARK: Functions
extension GoalView {
    func getDateStr(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: date)
    }
}
