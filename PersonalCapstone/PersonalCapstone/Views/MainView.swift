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
        Goal(title: "Do chores", description: "Chores", progress: 40, isCompleted: false)
    ]
    
    @State private var journals: [JournalEntry] = [JournalEntry(title: "Journal #1", text: "This is my first journal!"), JournalEntry(title: "Journal #2", text: "This is my second journal! Testing how well a long journal text works!")
    ]
    
    @State var isShowingGoals = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 1)
                    if isShowingGoals {
                        List() {
                            ForEach(Array(goals.enumerated()).reversed(), id: \.offset) { i, goal in
                                ZStack {
                                    NavigationLink {
                                        CreateGoalView(goals: $goals, isEditing: true, goal: goal, index: i)
                                    } label: {
                                        Text("")
                                    }
                                    .opacity(0.0)
                                    GoalView(goal: goal)
                                }
                            }
                            .onDelete { i in
                                goals.remove(atOffsets: i)
                            }
                         }
                        .background(Color.offWhite)
                        .scrollContentBackground(.hidden)
                    } else {
                        List {
                            ForEach(Array(journals.enumerated()).reversed(), id: \.offset) { i, entry in
                                ZStack {
//                                    NavigationLink {
//                                    } label: {
//                                        Text("")
//                                    }
//                                    .opacity(0.0)
                                    JournalView(journal: entry)
                                }
                            }
                        }
                        .listRowBackground(Color.white)
                    }
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
            .navigationTitle("Home")
            
            // MARK: Toolbar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        if isShowingGoals {
                            CreateGoalView(goals: $goals, isEditing: false)
                        } else {
                            CreateJournalView(journals: $journals, goals: $goals, isEditing: false)
                        }
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
