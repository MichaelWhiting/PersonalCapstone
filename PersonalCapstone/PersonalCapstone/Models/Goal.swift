//
//  Goal.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/6/23.
//

import SwiftUI

struct Goal: Identifiable, Hashable {
    static func == (lhs: Goal, rhs: Goal) -> Bool {
        return false
    }
    
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var progress: Double
    var isCompleted: Bool
    var creationDate: Date = Date()
    var steps: [Step]?
    
    func hash(into hasher: inout Hasher) {
        // leave blank
    }
}


