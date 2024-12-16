//
//  SplashScreenView.swift
//  nunu
//
//  Created by Riley Mitchell on 9/5/24.
//  "the news you need"

import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive: Bool
    @State private var opacity = 1.0

    var body: some View {
        VStack {
            Text("nunu")
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 2.0)) {
                opacity = 0.0 // Fade effect
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isActive = false // Switch to LoginView
            }
        }
        .opacity(opacity)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isActive: .constant(true))
    }
}



