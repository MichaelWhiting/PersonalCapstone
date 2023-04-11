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
    
    @State var newStepsArray: [Step] = []

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
                            reorderSteps(goal: goal, from: nil, to: nil)
                            try? moc.save()
                        }
                    }
                    .onMove { from, to in
                        reorderSteps(goal: goal, from: from, to: to)
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
                        reorderSteps(goal: nil, from: nil, to: nil)
                    }
                    .onMove { from, to in
                        reorderSteps(goal: nil, from: from, to: to)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            Spacer()
            Spacer()
        }
    }
}

extension StepListView {
    func reorderSteps(goal: Goal?, from: IndexSet?, to: Int?) {
        if let goal {
            if let from, let to {
                newStepsArray = goal.stepsArray
                newStepsArray.move(fromOffsets: from, toOffset: to)
                goal.steps = []

                for (i,step) in newStepsArray.enumerated() {
                    step.stepNum = i
                    goal.addToSteps(step)
                }
                
                try? moc.save()
            } else {
                newStepsArray = goal.stepsArray
                goal.steps = []

                for (i,step) in newStepsArray.enumerated() {
                    step.stepNum = i
                    goal.addToSteps(step)
                }
                
                try? moc.save()
            }
        } else {
            if let from, let to {
                newStepsArray = stepsToAdd
                newStepsArray.move(fromOffsets: from, toOffset: to)
                stepsToAdd = []
                
                for (i, step) in newStepsArray.enumerated() {
                    step.stepNum = i
                    stepsToAdd.append(step)
                }
                
                try? moc.save()
            } else {
                newStepsArray = stepsToAdd
                stepsToAdd = []
                
                for (i,step) in newStepsArray.enumerated() {
                    step.stepNum = i
                    stepsToAdd.append(step)
                }
                
                try? moc.save()
            }
        }
    }
}
