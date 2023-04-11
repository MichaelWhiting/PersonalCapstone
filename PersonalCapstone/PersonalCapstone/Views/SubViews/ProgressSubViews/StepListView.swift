//
//  StepListView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 4/4/23.
//

import SwiftUI

struct StepListView: View {
    @Environment(\.managedObjectContext) var moc

    var goal: Goal?
    var textColor: Color
    
    @State var presentStepCreate = false
    @Binding var stepsToAdd: [Step]

    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            if presentStepCreate {
                CreateStepView(goal: goal, textColor: textColor, presentStepCreate: $presentStepCreate, stepsToAdd: $stepsToAdd)
            }
            
            Button {
                withAnimation {
                    presentStepCreate.toggle()
                }
            } label: {
                Text(presentStepCreate ? "Cancel" : "Add Step")
                    .frame(width: 100, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(presentStepCreate ? Color.red : Color.blue, lineWidth: 2)
                    )
            }
            
            Divider()
            
            List {
                if let goal {
                    ForEach(goal.stepsArray, id: \.self) { step in
                        StepView(step: step)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            goal.removeFromSteps(goal.stepsArray[index])
                            try? moc.save()
                        }
                    }
                } else {
                    if stepsToAdd.isEmpty {
                      Spacer()
                    }
                    ForEach(stepsToAdd, id: \.self) { step in
                        StepView(step: step)
                    }
                    .onDelete { indexSet in
                        stepsToAdd.remove(atOffsets: indexSet)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            Spacer()
            Spacer()
        }
    }
}
