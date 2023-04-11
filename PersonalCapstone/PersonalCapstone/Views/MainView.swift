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
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.creationDate, order: .reverse)]) var goals: FetchedResults<Goal>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var entries: FetchedResults<Entry>
    
    @State private var goalsRefreshID = UUID()
    @State private var journalsRefreshID = UUID()
    
    @State var selectedListType = "Goals"
    @State var refresh = false
    
    var listTypes = ["Goals", "Journals"]

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 20)
                    Picker("Type", selection: $selectedListType) {
                        ForEach(listTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 200, alignment: .center)
                    
                    if selectedListType == "Goals" {
                        List {
                            ForEach(goals, id: \.self) { goal in
                                ZStack {
                                    NavigationLink {
                                        CreateGoalView(goal: goal)
                                            .onDisappear {
                                                self.goalsRefreshID = UUID()
                                            }
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
                            .id(goalsRefreshID)
                            .listRowBackground(colorScheme == .light ? Color.white : Color.secondaryBlack)
                         }
                        .scrollContentBackground(.hidden)
                        .refreshable {
                            refresh.toggle()
                        }
                    } else {
                        List {
                            ForEach(entries, id: \.self) { entry in
                                ZStack {
                                    NavigationLink {
                                        CreateJournalView(entry: entry)
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
                            .listRowBackground(colorScheme == .light ? Color.white : Color.secondaryBlack)
                        }
                        .scrollContentBackground(.hidden)
                        .refreshable {
                            refresh.toggle()
                        }
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .background(colorScheme == .light ? Color.secondaryWhite : .black)

                
                GeometryReader { reader in
                Color.primaryColor
                     .frame(height: reader.safeAreaInsets.top, alignment: .top)
                      .ignoresSafeArea()
                 }
            }
            .navigationTitle(selectedListType == "Goals" ? "Goals" : "Journal Entries")
            
            // MARK: Toolbar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        if selectedListType == "Goals" {
                            CreateGoalView()
                        } else {
                            CreateJournalView()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

extension MainView {
    // MARK: Functions
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
