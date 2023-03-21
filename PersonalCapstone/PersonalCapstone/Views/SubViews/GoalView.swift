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
        HStack(spacing: 15) {
            ZStack(alignment: .center) {
                Text("\(Int(goal.progress))%")
                    .font(.caption2)
                CircleProgressBar(progress: goal.progress, lineWidth: 7)
                    .frame(width: 40, height: 40)
            }
            VStack {
                HStack(alignment: .top, spacing: 5) {
                    Text("\(goal.title ?? "")")
                        .font(.headline)
                        .bold()
                    Spacer()
                    Text(getDateStr(date: goal.creationDate!))
                        .font(.callout)
                        .bold()
                }
                HStack {
                    Text("\(goal.goalDescription ?? "")")
                        .font(.subheadline)
                    Spacer()
                }
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
