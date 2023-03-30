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
    @State var selectedProgressType = "Steps"
    @State var goalSteps = [String]()
    @State var presentStepCreate = false

    var goal: Goal?
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Spacer()
                    List {
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
                    .scrollContentBackground(.hidden)
                    .onAppear {
                        checkGoal()
                    }
                }
                .frame(height: 150)
               
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
                    
                    // MARK: Progress Types
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
                    } else {
                        VStack(spacing: 10) {
                            Spacer()
                            if presentStepCreate {
                                CreateStepView(goal: goal, textColor: textColor, presentStepCreate: $presentStepCreate)
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
                                ForEach(goal?.stepsArray ?? [], id: \.self) { step in
                                    StepView(step: step)
                                }
                                .onDelete { indexSet in
                                    for index in indexSet {
                                        goal?.removeFromSteps(goal!.stepsArray[index])
                                        try? moc.save()
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden)
                            Spacer()
                            Spacer()
                            
                        }
                    }
                }

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
                alignment: .top
            )
            .background(colorScheme == .light ? Color.secondaryWhite : Color.black)
            .onAppear {
                if goal?.stepsArray.count ?? 0 > 0 {
                    var completedSteps = [Step]()
                    goal?.stepsArray.forEach { step in
                        if step.isComplete {
                            completedSteps.append(step)
                        }
                    }
                    withAnimation {
                        progress = Float(Double(completedSteps.count) / Double(goal?.stepsArray.count ?? 1) * 100.0)
                    }
                }
            }
            
            GeometryReader { reader in
                Color.primaryColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            selectedProgressType = goal?.stepsArray.count ?? 0 > 0 ? "Steps" : "Drag"
        }
        .navigationTitle(goal != nil ? "Edit Goal" : "Create Goal")
    }
}

struct CreateGoalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGoalView()
    }
}
