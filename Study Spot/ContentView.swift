//
//  ContentView.swift
//  Study Spot
//
//  Created by apple on 21/10/2026.
//



import SwiftUI
import SwiftData

let studyBackground = Color(red: 238.0 / 255, green: 240.0 / 255, blue: 228.0 / 255)
let studyGreen = Color(red: 28.0 / 255, green: 64.0 / 255, blue: 44.0 / 255)
let studyText = Color(red: 16.0 / 255, green: 45.0 / 255, blue: 30.0 / 255)
let fieldColor = Color(red: 251.0 / 255, green: 249.0 / 255, blue: 243.0 / 255)

struct ContentView: View {
    @AppStorage("isSignedIn") private var isSignedIn = false      // Unit 4.1
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        ZStack {
            if isSignedIn {
                MainTabView()
            } else {
                NavigationStack {
                    WelcomeView()
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: StudySpot.self)
}

// Screen 1: Welcome

struct WelcomeView: View {
    @State private var logoOpacity = 0.0

    var body: some View {
        ZStack {
            studyBackground.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Image("BookLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 210, height: 210)
                    .opacity(logoOpacity)

                Text("Study Spot\nLocator")
                    .font(.system(size: 36))
                    .bold()
                    .foregroundColor(studyText)
                    .multilineTextAlignment(.center)

                Rectangle()
                    .fill(studyGreen)
                    .frame(width: 54, height: 4)

                Text("Welcome to\nOur Library")
                    .font(.system(size: 26))
                    .bold()
                    .foregroundColor(studyText)
                    .multilineTextAlignment(.center)

                Spacer()

                NavigationLink(destination: SignInView()) {
                    HStack {
                        Text("Let's Get Started")
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(studyGreen)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation {
                logoOpacity = 1.0
            }
        }
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
    }
}
