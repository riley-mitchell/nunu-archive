//
//  ContentView.swift
//  NU
//
//  Created by Riley Mitchell on 8/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isSplashScreenActive = true
    @State private var isLoggedIn = false

    var body: some View {
        ZStack {
            if isSplashScreenActive {
                SplashScreenView(isActive: $isSplashScreenActive)
            } else if !isLoggedIn {
                LoginView(isLoggedIn: $isLoggedIn)
            } else {
                NavigationView {
                    VStack {
                        Spacer()

                        VStack(spacing: 20) {
                            NavigationLink(destination: Option1View()) {
                                Text("Happy")
                                    .modifier(SmallModernButtonStyle(gradient: LinearGradient(
                                        colors: [Color.cyan.opacity(0.7), Color.blue.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)))
                            }

                            NavigationLink(destination: Option2View()) {
                                Text("Sad")
                                    .modifier(SmallModernButtonStyle(gradient: LinearGradient(
                                        colors: [Color.mint.opacity(0.7), Color.teal.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)))
                            }

                            NavigationLink(destination: Option3View()) {
                                Text("Mad")
                                    .modifier(SmallModernButtonStyle(gradient: LinearGradient(
                                        colors: [Color.pink.opacity(0.7), Color.red.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)))
                            }

                            NavigationLink(destination: Option4View()) {
                                Text("Tired")
                                    .modifier(SmallModernButtonStyle(gradient: LinearGradient(
                                        colors: [Color.gray.opacity(0.7), Color.black.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)))
                            }

                            NavigationLink(destination: Option5View()) {
                                Text("Curious")
                                    .modifier(SmallModernButtonStyle(gradient: LinearGradient(
                                        colors: [Color.purple.opacity(0.7), Color.indigo.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)))
                            }

                            NavigationLink(destination: Option6View()) {
                                Text("Mixed")
                                    .modifier(SmallModernButtonStyle(gradient: LinearGradient(
                                        colors: [Color.green.opacity(0.7), Color.yellow.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)))
                            }

                            NavigationLink(destination: Option7View()) {
                                Text("Random")
                                    .modifier(SmallModernButtonStyle(gradient: LinearGradient(
                                        colors: [Color.orange.opacity(0.7), Color.yellow.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)))
                            }
                        }

                        Spacer()
                    }
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

struct SmallModernButtonStyle: ViewModifier {
    var gradient: LinearGradient

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 45)
            .padding()
            .background(gradient)
            .foregroundColor(.white)
            .font(.subheadline)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



