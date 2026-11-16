//
//  StudySpotsView.swift
//  Study Spot
//
//  Created by apple on 12/11/2026.
//

import SwiftUI

struct StudySpotsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    let studyBackground = Color(red: 238.0 / 255, green: 240.0 / 255, blue: 228.0 / 255)
    let studyGreen = Color(red: 28.0 / 255, green: 64.0 / 255, blue: 44.0 / 255)
    let studyText = Color(red: 16.0 / 255, green: 45.0 / 255, blue: 30.0 / 255)
    let fieldColor = Color(red: 251.0 / 255, green: 249.0 / 255, blue: 243.0 / 255)

    let cafeNotes = "A cozy spot with great coffee and a calm atmosphere."
    let libraryNotes = "Spacious, quiet, and perfect for focused study."

    var body: some View {
        ZStack {
            studyBackground.ignoresSafeArea()

            VStack(spacing: 16) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(studyText)
                    }

                    Spacer()
                }

                Text("Study Spots")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(studyText)

                Text("Discover great places to study\non campus.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(studyGreen)

                    TextField("Search spots...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)

                    Button {

                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(studyGreen)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }

                NavigationLink(destination: SpotDetailsView(
                    name: "Quiet Cafe",
                    icon: "cup.and.saucer.fill",
                    notes: cafeNotes,
                    hasCoffee: true
                )) {
                    HStack(spacing: 14) {
                        Image(systemName: "cup.and.saucer.fill")
                            .font(.system(size: 30))
                            .foregroundColor(studyGreen)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Quiet Cafe").font(.headline)
                            Text(cafeNotes)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(fieldColor)
                    .foregroundColor(studyText)
                    .cornerRadius(16)
                }
                .buttonStyle(.plain)

                NavigationLink(destination: SpotDetailsView(
                    name: "Campus Library",
                    icon: "building.columns.fill",
                    notes: libraryNotes,
                    hasCoffee: false
                )) {
                    HStack(spacing: 14) {
                        Image(systemName: "building.columns.fill")
                            .font(.system(size: 30))
                            .foregroundColor(studyGreen)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Campus Library").font(.headline)
                            Text(libraryNotes)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(fieldColor)
                    .foregroundColor(studyText)
                    .cornerRadius(16)
                }
                .buttonStyle(.plain)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        StudySpotsView()
    }
}
