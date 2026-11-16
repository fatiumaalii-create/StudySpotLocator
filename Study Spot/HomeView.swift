//
//  HomeView.swift
//  Study Spot
//
//  Created by apple on 05/11/2026.
//

import SwiftUI

struct HomeView: View {
    var onBack: () -> Void = {}

    let studyBackground = Color(red: 238.0 / 255, green: 240.0 / 255, blue: 228.0 / 255)
    let studyGreen = Color(red: 28.0 / 255, green: 64.0 / 255, blue: 44.0 / 255)
    let studyText = Color(red: 16.0 / 255, green: 45.0 / 255, blue: 30.0 / 255)
    let fieldColor = Color(red: 251.0 / 255, green: 249.0 / 255, blue: 243.0 / 255)

    var body: some View {
        ZStack {
            studyBackground.ignoresSafeArea()

            VStack(spacing: 16) {
                HStack {
                    Button(action: onBack) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(studyText)
                    }

                    Spacer()
                }
                .padding(.top, 16)

                Spacer()

                Text("Welcome, Student!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(studyText)

                Text("Find a quiet place. Get more done.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                Image("BookLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .padding(.vertical, 12)

                NavigationLink(destination: StudySpotsView()) {
                    HStack(spacing: 16) {
                        Image(systemName: "book.fill")
                            .font(.system(size: 30))
                        Text("Study Spots")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(fieldColor)
                    .foregroundColor(studyGreen)
                    .cornerRadius(20)
                }

                Button {
                    // نربطه بصفحة Map يوم تجهز.
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 30))
                        Text("Map")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(fieldColor)
                    .foregroundColor(studyGreen)
                    .cornerRadius(20)
                }

                Button {
                    // نربطه بصفحة My Reminders يوم تجهز.
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: "calendar")
                            .font(.system(size: 30))
                        Text("My Reminders")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(fieldColor)
                    .foregroundColor(studyGreen)
                    .cornerRadius(20)
                }

                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
