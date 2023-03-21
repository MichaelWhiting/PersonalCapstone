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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var goals: FetchedResults<Goal>
//    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<Entry>
    @State var entries: [Entry] = []
    @State var selectedGoal: Goal?
    @State var isShowingGoals = true
    @State var refresh: Bool = false
    
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
                            ForEach(goals, id: \.self) { goal in
                                ZStack {
                                    NavigationLink {
                                        CreateGoalView(isEditing: true, refresh: $refresh, goal: goal)
                                    } label: {
                                        Text("")
                                    }
                                    .opacity(0.0)
                                    GoalView(goal: goal)
                                }
                            }
                            .onDelete { indexSet in
                                deleteItem(indexSet: indexSet, type: "Goal")
                            }
                         }
                        .onAppear {
                            moc.refreshAllObjects()
                        }
                        .background(Color.offWhite)
                        .scrollContentBackground(.hidden)
                    } else {
                        List {
                            ForEach(Array(entries.enumerated()), id: \.offset) { i, entry in
                                ZStack {
                                    NavigationLink {
                                        // journals
                                    } label: {
                                        Text("")
                                    }
                                    .opacity(0.0)
                                    JournalView(journal: entry)
                                }
                            }
                            .onDelete { indexSet in
                                deleteItem(indexSet: indexSet, type: "Entry")
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
                            CreateGoalView(isEditing: false, refresh: $refresh)
                        } else {
                            CreateJournalView(isEditing: false)
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

extension MainView {
    // MARK: Delete Functions
    func deleteItem(indexSet: IndexSet, type: String) {
        for index in indexSet {
            if type == "Goal" {
                let goal = goals[index]
                moc.delete(goal)
            } else {
                let entry = entries[index]
                moc.delete(entry)
            }
        }
        do {
            try moc.save()
        } catch {
            print("Error with saving deletion: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
