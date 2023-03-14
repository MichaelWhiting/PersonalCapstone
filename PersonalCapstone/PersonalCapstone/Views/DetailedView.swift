//
//  DetailedView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/13/23.
//

import SwiftUI

struct DetailedView: View {
//    var goal: Goal
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                List {
                    Text("Goal Description:")
                }
            }
            
            GeometryReader { reader in
            Color.primaryColor
                 .frame(height: reader.safeAreaInsets.top, alignment: .top)
                  .ignoresSafeArea()
             }
        }
        .navigationBarTitle("Goal Title")
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView()
    }
}
