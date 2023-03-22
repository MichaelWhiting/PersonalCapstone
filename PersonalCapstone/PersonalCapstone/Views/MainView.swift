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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.progress, order: .reverse)]) var goals: FetchedResults<Goal>
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<Entry>
    
    @State private var goalsRefreshID = UUID()
    @State private var journalsRefreshID = UUID()
    
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
                        List {
                            ForEach(goals, id: \.self) { goal in
                                ZStack {
                                    NavigationLink {
                                        CreateGoalView(isEditing: true, goal: goal)
                                            .onDisappear {
                                                self.goalsRefreshID = UUID()
                                            }
                                    } label: {
                                        Text("")
                                    }

                                    .opacity(0.0)
                                    GoalView(goal: goal) // when called after editing cell time this isn't hitting the code that makes the actual cell view
                                }
                            }
                            .onDelete { indexSet in
                                deleteItem(indexSet: indexSet, type: "Goal")
                            }
                            .id(goalsRefreshID)
                         }
//                        .onAppear {
//                            moc.refreshAllObjects()
//                        }
                        .background(Color.offWhite)
                        .scrollContentBackground(.hidden)
                    } else {
                        List {
                            ForEach(entries, id: \.self) { entry in
                                ZStack {
                                    NavigationLink {
                                        CreateJournalView(isEditing: true, entry: entry)
                                            .onDisappear {
                                                self.journalsRefreshID = UUID()
                                            }
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
                            .id(journalsRefreshID)
                        }
                        .listRowBackground(Color.white)
                    }
                }
                .onAppear {
                    moc.refreshAllObjects()
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
                            CreateGoalView(isEditing: false)
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
