//
//  JournalView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/9/23.
//

import SwiftUI

struct JournalView: View {
    let journal: Entry

    var body: some View {
        VStack(spacing: 5) {
            HStack(alignment: .top, spacing: 5) {
                Text("\(journal.title ?? "")")
                    .font(.headline)
                    .bold()
                Spacer()
                Text(getDateStr(date: journal.createdDate!))
                    .font(.callout)
                    .bold()
            }
            HStack {
                Text("  \(journal.text ?? "")")
                    .font(.subheadline)
                    .lineLimit(3)
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
