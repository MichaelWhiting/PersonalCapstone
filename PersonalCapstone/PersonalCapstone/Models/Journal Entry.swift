//
//  Journal Entry.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/6/23.
//

import Foundation

struct JournalEntry: Hashable {
    var title: String
    var text: String
    var creationDate: Date = Date()
    var relatedGoals: [Goal]?
    
    func hash(into hasher: inout Hasher) {
        // leave blank
    }
}
