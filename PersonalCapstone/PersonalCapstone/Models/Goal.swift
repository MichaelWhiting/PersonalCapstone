//
//  Goal.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/6/23.
//

import Foundation

struct Goal: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var progress: Double
    var isCompleted: Bool
    var creationDate: Date = Date()
    var steps: [Step]?
}


