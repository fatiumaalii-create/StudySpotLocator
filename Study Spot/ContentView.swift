//
//  ContentView.swift
//  Study Spot
//
//  Created by apple on 21/10/2026.
//

import SwiftUI

struct ContentView: View {
    let studyBackground = Color(red: 238.0 / 255, green: 240.0 / 255, blue: 228.0 / 255)
    let studyGreen = Color(red: 28.0 / 255, green: 64.0 / 255, blue: 44.0 / 255)
    let studyText = Color(red: 16.0 / 255, green: 45.0 / 255, blue: 30.0 / 255)

    var body: some View {
        NavigationStack {
            ZStack {
                studyBackground
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    Image("BookLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210, height: 210)

                    Text("Study Spot\nLocator")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(studyText)
                        .multilineTextAlignment(.center)

                    Rectangle()
                        .fill(studyGreen)
                        .frame(width: 54, height: 4)

                    Text("Welcome to\nOur Library")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
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
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
#Preview {
    SignInView()
}
