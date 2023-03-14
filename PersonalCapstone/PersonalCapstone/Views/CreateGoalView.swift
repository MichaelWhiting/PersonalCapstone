//
//  CreateGoalView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/7/23.
//

import SwiftUI

struct CreateGoalView: View {
    @Environment(\.dismiss) var dismiss

    @State private var titleStr = ""
    @State private var descriptionStr = ""
    @State private var progress: Float = 0.0
    
    @Binding var goals: [Goal]
    
    @State var isEditing: Bool
    var goal: Goal?
    var index: Int?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                List {
                    HStack(alignment: .center) {
                        Text("Goal Title:")
                            .font(.headline)
                            .bold()
                        TextField("Title", text: $titleStr)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack(alignment: .center) {
                        Text("Goal Description: ")
                            .font(.headline)
                            .bold()
                        TextField("Description", text: $descriptionStr)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    VStack {
                        Text("Current Progress")
                            .font(.title3)
                            .bold()
                        Spacer()
                        ZStack {
                            Text("\(Int(progress))%")
                                .font(.title2)
                                .bold()
                            CircleProgressBar(progress: Double(progress), lineWidth: 20)
                                .frame(width: 200, height: 200)
                        }
                        
                        Slider(value: $progress, in: 0...100)
                    }
                    .frame(width: 300, height: 300)
                    
                }
                .scrollContentBackground(.hidden)
                .onAppear {
                    checkGoal()
                }
                HStack(alignment: .center) {
                    Spacer()
                    Button(isEditing ? "Save" : "Create") {
                        checkTextBoxes()
                    }
                    .roundDarkButton()
                    Spacer()
                }
                Spacer()
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(Color.white)
            
            GeometryReader { reader in
                Color.primaryColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle(isEditing ? "Edit Goal" : "Create Goal")
    }
}

// MARK: Functions
extension CreateGoalView {
    func checkTextBoxes() {
        if isEditing {
            if !titleStr.isEmpty && !descriptionStr.isEmpty {
                let newGoal = Goal(title: titleStr, description: descriptionStr, progress: Double(progress), isCompleted: false)
                goals.remove(at: index!)
                goals.append(newGoal)
                
                dismiss()
            }
        } else {
            if !titleStr.isEmpty && !descriptionStr.isEmpty {
                let newGoal = Goal(title: titleStr, description: descriptionStr, progress: Double(progress), isCompleted: false)
                goals.append(newGoal)
                dismiss()
            }
        }
    }
    
    func checkGoal() {
        if let goal = goal {
            titleStr = goal.title
            descriptionStr = goal.description
            progress = Float(goal.progress)
        }
    }
}

struct CreateGoalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGoalView(goals: .constant([]), isEditing: false)
    }
}
