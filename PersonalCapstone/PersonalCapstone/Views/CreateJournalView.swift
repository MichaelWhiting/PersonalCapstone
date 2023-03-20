//
//  CreateJournalView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/17/23.
//

import SwiftUI

struct CreateJournalView: View {
    
    @State private var title = ""
    @State private var text = ""
    @State private var relatedGoals: [Goal] = []

    @Binding var journals: [JournalEntry]
    @Binding var goals: [Goal]
    
    @State var isEditing: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                List {
                    HStack {
                        Text("Journal Title:")
                        TextField("Title", text: $title)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack {
                        Text("Journal Text:")
                        TextField("Text", text: $text)
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack {
                        Text("Related Goals:")
                        List($goals, id: \.self) { goal in
                            Text("\(goal.title)")
                        }
                    }
                }
            }
            
            GeometryReader { reader in
                Color.primaryColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle("Create Journal")
    }
}

struct CreateJournalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateJournalView(journals: .constant([]), goals: .constant([]), isEditing: false)
    }
}
