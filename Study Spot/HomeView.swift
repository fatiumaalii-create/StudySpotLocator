//
//  HomeView.swift
//  Study Spot
//
//  Created by apple on 05/11/2026.
//


import SwiftUI

// Screen 4: Home
struct HomeView: View {
    @AppStorage("studentName") private var savedName = ""      // saved in Settings

    private var greetingName: String {
        if savedName.isEmpty {
            return "Student"
        } else {
            return savedName
        }
    }

    var body: some View {
        ZStack {
            studyBackground.ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                Text("Welcome, \(greetingName)!")
                    .font(.system(size: 28))
                    .bold()
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

                NavigationLink(destination: StudyMapView()) {
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

                NavigationLink(destination: MyRemindersView()) {
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
