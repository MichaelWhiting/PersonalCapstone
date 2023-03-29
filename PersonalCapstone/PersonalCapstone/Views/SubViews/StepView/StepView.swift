//
//  StepView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/27/23.
//

import SwiftUI

struct StepView: View {
    var title: String
    var stepNum: Int
    var isComplete: Bool
    
    var body: some View {
        HStack {
            Text("\(title)")
                .font(.headline)
            Spacer()
            Button {

            } label: {
                Image(systemName: isComplete ? "checkmark.circle.fill" : "checkmark.circle")
            }
        }
    }
}
