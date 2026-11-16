//
//  MainTabView.swift
//  Study Spot
//
//  Created by apple on 12/11/2026.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        TabView {
            NavigationStack {
                HomeView(onBack: {
                    dismiss()
                })
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            NavigationStack {
                StudyMapView(spotName: nil, showBack: false)
            }
            .tabItem {
                Image(systemName: "mappin")
                Text("Map")
            }

            NavigationStack {
                Text("Settings")
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
        .tint(Color(red: 28.0 / 255, green: 64.0 / 255, blue: 44.0 / 255))
        .navigationBarHidden(true)
    }
}

#Preview {
    MainTabView()
}
