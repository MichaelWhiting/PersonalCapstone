//
//  CreateStepView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/30/23.
//

import SwiftUI

struct CreateStepView: View {
    @Environment(\.managedObjectContext) var moc
    @State var titleStr: String = ""
    
    var goal: Goal?
    var textColor: Color
    
    @Binding var presentStepCreate: Bool
    
    var body: some View {
        Divider()
        VStack {
            Text("Create Step")
                .foregroundColor(textColor)
                .font(.headline)
                .bold()
            HStack {
                Text("Title:")
                    .foregroundColor(textColor)
                    .bold()
                TextField("Title", text: $titleStr)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            Button {
                createNewStep()
            } label: {
                Text("Add")
                    .frame(width: 100, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.green, lineWidth: 2)
                    )
            }
        }
        .background(.clear)
    }
}

extension CreateStepView {
    func createNewStep() {
        if let goal {
            let newStep = Step(context: moc)
            newStep.goal = goal
            newStep.isComplete = false
            newStep.title = titleStr
            newStep.stepNum = goal.stepsArray.count + 1
            
            goal.addToSteps(newStep)
            
            try? moc.save()
            
            withAnimation {
                presentStepCreate.toggle()
            }
        }
    }
}

