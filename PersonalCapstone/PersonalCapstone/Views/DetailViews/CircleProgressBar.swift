//
//  CircleProgressBar.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/14/23.
//

import SwiftUI

struct CircleProgressBar: View {
    let progress: Double
    let lineWidth: CGFloat
    
    var body: some View {
        Circle()
            .stroke(
                Color.green.opacity(0.3),
                lineWidth: lineWidth
            )
        Circle()
            .trim(from: 0, to: progress / 100)
            .stroke(Gradient(colors: [.green.opacity(0.2), .green]), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .rotationEffect(.degrees(-90))
            .animation(.easeOut, value: progress / 100)
    }
}
