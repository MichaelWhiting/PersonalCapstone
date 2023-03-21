//
//  PersonalCapstoneApp.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/6/23.
//

import SwiftUI

@main
struct PersonalCapstoneApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
