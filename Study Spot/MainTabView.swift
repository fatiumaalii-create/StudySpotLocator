//
//  MainTabView.swift
//  Study Spot
//
//  Created by apple on 12/11/2026.
//



import SwiftUI
import SwiftData

// Unit 3.2: TabView with Home, Map and Settings
struct MainTabView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var spots: [StudySpot]

    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            NavigationStack {
                StudyMapView()
            }
            .tabItem {
                Image(systemName: "mappin")
                Text("Map")
            }

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
        .tint(studyGreen)
        .onAppear {
            addStartingSpots()
        }
    }

    // First time only: save the two starting spots in the database
    private func addStartingSpots() {
        if spots.isEmpty {
            let cafe = StudySpot(
                name: "Quiet Cafe",
                notes: "A cozy spot with great coffee and a calm atmosphere.",
                icon: "cup.and.saucer.fill",
                rating: 4,
                hasCoffee: true
            )
            let library = StudySpot(
                name: "Campus Library",
                notes: "Spacious, quiet, and perfect for focused study.",
                icon: "building.columns.fill",
                rating: 4,
                hasCoffee: false
            )
            modelContext.insert(cafe)
            modelContext.insert(library)
        }
    }
}
