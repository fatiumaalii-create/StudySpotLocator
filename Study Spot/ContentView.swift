//
//  ContentView.swift
//  Study Spot
//
//  Created by apple on 21/10/2026.
//

import SwiftUI

enum StudyTheme {
    static let background = Color(red: 0.93, green: 0.94, blue: 0.89)
    static let ink = Color(red: 0.06, green: 0.17, blue: 0.11)
    static let green = Color(red: 0.09, green: 0.24, blue: 0.16)
    static let accent = Color(red: 0.23, green: 0.41, blue: 0.27)
    static let cream = Color(red: 0.99, green: 0.98, blue: 0.95)
    static let muted = Color(red: 0.33, green: 0.35, blue: 0.32)
    static let border = Color(red: 0.85, green: 0.86, blue: 0.81)
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        Spacer(minLength: 36)

                        Image("BookLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 230, height: 210)
                            .accessibilityHidden(true)

                        Text("Study Spot\nLocator")
                            .font(.system(size: 40, weight: .heavy, design: .rounded))
                            .multilineTextAlignment(.center)
                            .padding(.top, 12)

                        Rectangle()
                            .fill(StudyTheme.accent)
                            .frame(width: 54, height: 4)
                            .padding(.top, 18)

                        Text("Welcome to\nOur Library")
                            .font(.system(size: 27, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .padding(.top, 26)

                        Spacer(minLength: 32)

                        NavigationLink {
                            SignInView()
                        } label: {
                            HStack(spacing: 12) {
                                Text("Let’s Get Started")
                                Image(systemName: "arrow.right")
                            }
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .background(StudyTheme.green, in: RoundedRectangle(cornerRadius: 16))
                        }
                        .buttonStyle(.plain)
                        .padding(.bottom, 38)
                    }
                    .foregroundStyle(StudyTheme.ink)
                    .frame(maxWidth: 420)
                    .padding(.horizontal, 22)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: geometry.size.height)
                }
            }
            .background(StudyTheme.background.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
