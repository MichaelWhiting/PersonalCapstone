//
//  CreateJournalFunctions.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/22/23.
//

import Foundation

extension CreateJournalView {
    func checkTextBoxes() {
        if !titleStr.isEmpty && !textStr.isEmpty {
            if let entry {
                entry.title = titleStr
                entry.text = textStr
                
                try? moc.save()
                
                dismiss()
            } else {
                let entry = Entry(context: moc)
                entry.title = titleStr
                entry.text = textStr
                entry.createdDate = Date()
                
                try? moc.save()
                
                dismiss()
            }
        }
    }
    
    func checkEntry() {
        if let entry {
            titleStr = entry.title ?? ""
            textStr = entry.text ?? ""
        }
    }
}
