//
//  CreateJournalView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/17/23.
//

import SwiftUI

struct CreateJournalView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var titleStr = ""
    @State private var textStr = ""
    @State private var relatedGoals: [Goal] = []
    
    @State var isEditing: Bool
    
    var entry: Entry?
    
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Spacer()
                List {
                    HStack {
                        Text("Journal Title:")
                            .bold()
                        TextField("Title", text: $titleStr)
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack(spacing: 5) {
                        Text("Journal Text:")
                            .bold()
                        TextField("Description", text: $textStr, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(10)
                    }
                    .padding(8)
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Button(isEditing ? "Save" : "Create") {
                            checkTextBoxes()
                        }
                        .roundDarkButton()
                        Spacer()
                    }
                }
                .scrollContentBackground(.hidden)
                .onAppear() {
                    checkEntry()
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

extension CreateJournalView {
    // MARK: Functions
    func checkTextBoxes() {
        if isEditing {
            if !titleStr.isEmpty && !textStr.isEmpty {
                if let entry {
                    entry.title = titleStr
                    entry.text = textStr
                }
                
                try? moc.save()
                
                dismiss()
            }
        } else {
            if !titleStr.isEmpty && !textStr.isEmpty {
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

struct CreateJournalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateJournalView(isEditing: false)
    }
}
