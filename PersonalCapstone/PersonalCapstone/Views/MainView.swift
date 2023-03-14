//
//  ContentView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/6/23.
//

import SwiftUI

enum TableViewType {
    case goals, journals
}

struct MainView: View {
    @State private var goals: [Goal] = [
        Goal(title: "Do Homework", description: "Homework", progress: 40, isCompleted: false),
        Goal(title: "Learn Swift", description: "Coding", progress: 10, isCompleted: false),
        Goal(title: "Finish Capstone", description: "Project", progress: 15, isCompleted: false),
        Goal(title: "Work on internship", description: "Job", progress: 20, isCompleted: false),
        Goal(title: "Do chores", description: "Chores", progress: 40, isCompleted: false),
        Goal(title: "Goal 1", description: "Test", progress: 40, isCompleted: false),
        Goal(title: "Goal 2", description: "Test", progress: 10, isCompleted: false),
        Goal(title: "Goal 3", description: "Test", progress: 15, isCompleted: false),
        Goal(title: "Goal 4", description: "Test", progress: 20, isCompleted: false),
        Goal(title: "Goal 5", description: "Test", progress: 40, isCompleted: false),
        Goal(title: "Goal 6", description: "Test", progress: 54, isCompleted: false),
        Goal(title: "Goal 7", description: "Test", progress: 33, isCompleted: false)
    ]
    
    @State private var journals: [JournalEntry] = [JournalEntry(title: "Journal #1", text: "This is my first journal!"), JournalEntry(title: "Journal #2", text: "This is my second journal! Testing how well a long journal text works!")
    ]
    
    @State var isShowingGoals = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    if isShowingGoals {
                        List($goals, id: \.self, editActions: .delete) { goal in
                            ZStack {
                                NavigationLink {
                                    CreateGoalView(goals: $goals, isEditing: true, goal: goal.wrappedValue)
                                } label: {
                                    Text("")
                                }
                                .opacity(0.0)
                                GoalView(goal: goal.wrappedValue)
                            }
                        }
                        .listRowBackground(Color.secondaryColor)
                    } else {
                        List($journals, id: \.self, editActions: .delete) { journal in
                            JournalView(journal: journal.wrappedValue)
                        }
                        .listRowBackground(Color.secondaryColor)
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                
                GeometryReader { reader in
                Color.primaryColor
                     .frame(height: reader.safeAreaInsets.top, alignment: .top)
                      .ignoresSafeArea()
                 }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CreateGoalView(goals: $goals, isEditing: false)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button() {
                        isShowingGoals.toggle()
                    } label: {
                        let type = isShowingGoals ? "book" : "stairs"
                        Image(systemName: type)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
