//
//  Custom Modifiers.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/7/23.
//

import SwiftUI

extension View {
    func roundDarkButton() -> some View {
        modifier(RoundedDarkButton())
    }
}

struct RoundedDarkButton: ViewModifier {
    // Creates a rounded button using the secondary color
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .buttonBorderShape(.roundedRectangle(radius: 25))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.secondaryColor)
            )
    }
}

