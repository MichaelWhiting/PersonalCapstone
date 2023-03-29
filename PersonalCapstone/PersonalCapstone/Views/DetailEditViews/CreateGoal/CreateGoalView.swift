//
//  CreateGoalView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/7/23.
//

import SwiftUI

struct CreateGoalView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var textColor: Color {
        return colorScheme == .light ? .black : .white
    }

    @State var titleStr = ""
    @State var descriptionStr = ""
    @State var progress: Float = 0.0
    @State var selectedProgressType = "Drag"

    var goal: Goal?
    @State var goalSteps = [String]()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                List {
                    Group {
                        HStack(alignment: .center) {
                            Text("Goal Title:")
                                .foregroundColor(textColor)
                                .font(.headline)
                                .bold()
                            TextField("Title", text: $titleStr)
                                .foregroundColor(textColor)
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack(alignment: .center) {
                            Text("Goal Description: ")
                                .foregroundColor(textColor)
                                .font(.headline)
                                .bold()
                            TextField("Description", text: $descriptionStr)
                                .foregroundColor(textColor)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .onAppear {
                    checkGoal()
                }
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        Picker("Progress Type", selection: $selectedProgressType) {
                            ForEach(["Drag", "Steps"], id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 300)
                        Spacer()
                    }
 
    
                    if selectedProgressType == "Drag" {
                        VStack {
                            Text("Current Progress")
                                .foregroundColor(textColor)
                                .font(.title3)
                                .bold()
                            Spacer()
                            ZStack {
                                Text("\(Int(progress))%")
                                    .foregroundColor(textColor)
                                    .font(.title2)
                                    .bold()
                                CircleProgressBar(progress: Double(progress), lineWidth: 20)
                                    .frame(width: 200, height: 200)
                            }
                            
                            Slider(value: $progress, in: 0...100)
                        }
                        .frame(width: 300, height: 300)
                    }
                    
                    if selectedProgressType == "Steps" {
                        List {
                            ForEach(goal?.stepsArray ?? [], id: \.self) { step in
                                StepView(title: step.title ?? "", stepNum: step.stepNum, isComplete: step.isComplete)
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    goal?.removeFromSteps(goal!.stepsArray[index])
                                    try? moc.save()
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                Spacer()
                
                HStack(alignment: .center) {
                    Spacer()
                    Button(goal != nil ? "Save" : "Create") {
                        checkTextBoxes()
                    }
                    .roundDarkButton()
                    .foregroundColor(textColor)
                    Spacer()
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(colorScheme == .light ? Color.secondaryWhite : Color.black)
            
            GeometryReader { reader in
                Color.primaryColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle(goal != nil ? "Edit Goal" : "Create Goal")
    }
}

struct CreateGoalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGoalView()
    }
}
