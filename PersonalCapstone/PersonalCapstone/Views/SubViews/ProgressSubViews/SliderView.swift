//
//  SliderView.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 4/4/23.
//

import SwiftUI

struct SliderView: View {
    var textColor: Color
    var progress: Float
    
    var body: some View {
        Text("Current Progress")
            .foregroundColor(textColor)
            .font(.title3)
            .bold()
        Spacer()
        ZStack {
            Text("\(Int(progress))%")
                .foregroundColor(textColor)
                .font(.title2)
                .bold()
            CircleProgressBar(progress: Double(progress), lineWidth: 20)
                .frame(width: 200, height: 200)
        }
    }
}
