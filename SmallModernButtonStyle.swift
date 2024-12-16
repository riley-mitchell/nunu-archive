//
//  SmallModernButtonStyle.swift
//  nunu
//
//  Created by Riley Mitchell on 10/18/24.
//

import SwiftUI

struct SmallModernButtonStyle: ViewModifier {
    var gradient: LinearGradient

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, minHeight: 45)
            .background(gradient)
            .foregroundColor(.white)
            .font(.subheadline)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 8)
    }
}

extension View {
    func smallModernButtonStyle(gradient: LinearGradient) -> some View {
        self.modifier(SmallModernButtonStyle(gradient: gradient))
    }
}

