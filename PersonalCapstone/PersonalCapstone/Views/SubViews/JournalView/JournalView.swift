//
//  JournalView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/9/23.
//

import SwiftUI

struct JournalView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var textColor: Color {
        return colorScheme == .light ? .black : .white
    }
    
    let journal: Entry

    var body: some View {
        VStack(spacing: 5) {
            HStack(alignment: .top, spacing: 5) {
                Text("\(journal.title ?? "")")
                    .foregroundColor(textColor)
                    .font(.headline)
                    .bold()
                Spacer()
                Text(getDateStr(date: journal.createdDate!))
                    .foregroundColor(textColor)
                    .font(.callout)
                    .bold()
            }
            HStack {
                Text("  \(journal.text ?? "")")
                    .foregroundColor(textColor)
                    .font(.subheadline)
                    .lineLimit(3)
            }
        }

    }
}

