//
//  StepView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/27/23.
//

import SwiftUI

struct StepView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var step: Step
    
    var body: some View {
        HStack {
            Text("\(step.stepNum)")
            Text(step.title ?? "")
                .font(.headline)
            Spacer()
            Button {
                step.isComplete.toggle()
                try? moc.save()
            } label: {
                Image(systemName: step.isComplete ? "checkmark.circle.fill" : "x.circle")
            }            
        }
    }
}
