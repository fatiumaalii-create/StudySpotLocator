//
//  SettingsView.swift
//  Study Spot
//
//  Created by apple on 25/11/2026.
//

//
//  SettingsView.swift
//  Study Spot
//

import SwiftUI

// Screen 10: Settings
struct SettingsView: View {
    // Unit 4.1: @AppStorage keeps the values after the app is closed
    @AppStorage("studentName") private var savedName = ""
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isSignedIn") private var isSignedIn = false

    @State private var name = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        Form {
            Section("Your Name") {
                TextField("Student Name", text: $name)
            }

            Section {
                Toggle("Dark Mode", isOn: $isDarkMode)
            }

            Section {
                Button("Save Settings") {
                    saveSettings()
                }
            }

            Section {
                Button("Sign Out") {
                    isSignedIn = false          // ContentView goes back to the start
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            name = savedName
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func saveSettings() {
        if name.isEmpty {
            alertTitle = "Missing Information"
            alertMessage = "Please enter your name."
        } else {
            savedName = name
            alertTitle = "Settings Saved"
            alertMessage = "Your settings were saved."
        }

        showAlert = true
    }
}
