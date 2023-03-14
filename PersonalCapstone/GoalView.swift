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
        ZStack {
            VStack {
                HStack(alignment: .top, spacing: 5) {
                    Text("\(goal.title)")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text("2/4/23")
                }
                HStack {
                    Text(goal.description)
                    Spacer()
                    Text("47%") // Try to make this a progress bar later on
                }
            }
        }
    }
}
