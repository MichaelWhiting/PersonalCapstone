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
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var textColor: Color {
        return colorScheme == .light ? .black : .white
    }
    
    @State var titleStr = ""
    @State var textStr = ""
    @State var relatedGoals: [Goal] = []
        
    var entry: Entry?
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Spacer()
                List {
                    HStack {
                        Text("Journal Title:")
                            .foregroundColor(textColor)
                            .bold()
                        TextField("Title", text: $titleStr)
                            .foregroundColor(textColor)
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack(spacing: 5) {
                        Text("Journal Text:")
                            .foregroundColor(textColor)
                            .bold()
                        TextField("Description", text: $textStr, axis: .vertical)
                            .foregroundColor(textColor)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(20)
                    }
                    .padding(8)
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Button(entry != nil ? "Save" : "Create") {
                            checkTextBoxes()
                        }
                        .roundDarkButton()
                        .foregroundColor(textColor)
                        Spacer()
                    }
                }
                .scrollContentBackground(.hidden)
                .onAppear() {
                    checkEntry()
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(colorScheme == .light ? Color.secondaryWhite : Color.black)
            
            GeometryReader { reader in
                Color.primaryColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle(entry != nil ? "Edit Journal" : "Create Journal")
    }
}

struct CreateJournalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateJournalView()
    }
}
