//
//  JournalView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/9/23.
//

import SwiftUI

struct JournalView: View {
    let journal: JournalEntry

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 5) {
                Text("\(journal.title)")
                    .font(.title3)
                    .bold()
                Spacer()
                Text(getDateStr(date: journal.creationDate))
            }
            HStack {
                Text(journal.text)
                Spacer()
                Text("Related Goals")
            }
        }

    }
}

// MARK: Functions
extension JournalView {
    func getDateStr(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: date)
    }
}
