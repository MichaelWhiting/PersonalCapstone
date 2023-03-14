//
//  ContentView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/6/23.
//

import SwiftUI

struct MainView: View {
    @State private var goals: [Goal] = [
        Goal(title: "Do Homework", description: "Homework", progress: 40, isCompleted: false),
        Goal(title: "Learn Swift", description: "Coding", progress: 10, isCompleted: false)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Text("Hello Where is this?")
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    .background(Color.primaryColor)
                VStack(alignment: .leading, spacing: 15) {
                    Text("Home")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    List(0..<goals.count) { i in
                        var goal = goals[i]
                        VStack {
                            HStack(alignment: .top, spacing: 5) {
                                Text("-\(goal.title)")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("2/4/23")
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Text(goal.description)
                                    .foregroundColor(.white)
                                Spacer()
                                ZStack {
                                    Text("")
                                        .background(.green)
                                    Text("")
                                        .background(.black)
                                }
                            }
                        }

                        .listRowBackground(Color.primaryColor)
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
