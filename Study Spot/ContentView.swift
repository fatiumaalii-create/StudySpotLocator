//
//  ContentView.swift
//  Study Spot
//
//  Created by apple on 21/10/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.green.opacity(0.15)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    Image("BookLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210, height: 210)

                    Text("Study Spot\nLocator")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)

                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 54, height: 4)

                    Text("Welcome to\nOur Library")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
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
                        .background(Color.green.opacity(0.85))
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
