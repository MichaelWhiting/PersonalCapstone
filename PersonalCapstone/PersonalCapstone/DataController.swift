//
//  DataController.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/20/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Goal")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load goals: \(error.localizedDescription)")
            }
        }
    }
}
