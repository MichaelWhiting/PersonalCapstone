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
    
    @State var selectedProgressType = "Progress"
    @State var goalSteps = [String]()
    @State var stepsToAdd = [Step]()
    
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
                            ForEach(["Slider", "Steps"], id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 300)
                        Spacer()
                    }
                    
                    // MARK: Progress Types
                    if selectedProgressType == "Slider" {
                        VStack {
                            SliderView(textColor: textColor, progress: progress)
                            if goal?.stepsArray.count ?? 0 <= 0 {
                                Slider(value: $progress, in: 0...100)
                            }
                        }
                        .frame(width: 300, height: 300)
                    } else {
                        StepListView(goal: goal, textColor: textColor, stepsToAdd: $stepsToAdd)
                    }
                }

                Spacer()
                
                // MARK: Save Button
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
            
            GeometryReader { reader in
                Color.primaryColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            selectedProgressType = goal?.stepsArray.count ?? 0 > 0 ? "Steps" : "Slider"
        }
        .navigationTitle(goal != nil ? "Edit Goal" : "Create Goal")
    }
}

struct CreateGoalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGoalView()
    }
}
