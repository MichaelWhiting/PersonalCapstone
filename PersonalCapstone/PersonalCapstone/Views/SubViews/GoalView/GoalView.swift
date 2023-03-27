//
//  GoalView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/9/23.
//

import SwiftUI

struct GoalView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var textColor: Color {
        return colorScheme == .light ? .black : .white
    }
    
    var goal: Goal

    var body: some View {
        HStack(spacing: 15) {
            ZStack(alignment: .center) {
                Text("\(Int(goal.progress))%")
                    .foregroundColor(textColor)
                    .font(.caption2)
                CircleProgressBar(progress: goal.progress, lineWidth: 7)
                    .frame(width: 40, height: 40)
            }
            VStack {
                HStack(alignment: .top, spacing: 5) {
                    Text("\(goal.title ?? "")")
                        .foregroundColor(textColor)
                        .font(.headline)
                        .bold()
                    Spacer()
                    Text(getDateStr(date: goal.creationDate!))
                        .foregroundColor(textColor)
                        .font(.callout)
                        .bold()
                }
                HStack {
                    Text("\(goal.goalDescription ?? "")")
                        .foregroundColor(textColor)
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
    }
}
