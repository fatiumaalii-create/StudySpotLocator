//
//  AddSpotView.swift
//  Study Spot
//
//  Created by apple on 25/11/2026.
//



import SwiftUI
import SwiftData

struct AddSpotView: View {
    @Environment(\.modelContext) private var modelContext

    var spotToEdit: StudySpot? = nil

    @State private var name = ""
    @State private var notes = ""
    @State private var rating = 0
    @State private var hasCoffee = false

    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        Form {
            Section("Spot Details") {
                TextField("Name", text: $name)
                TextField("Notes", text: $notes)

                Picker("Rating", selection: $rating) {
                    ForEach(0...5, id: \.self) { number in
                        Text(number == 0 ? "Not rated yet" : "\(number)/5")
                    }
                }

                Toggle("Coffee available", isOn: $hasCoffee)
            }

            Section {
                Button("Save Spot") {
                    saveSpot()
                }
            }
        }
        .navigationTitle(spotToEdit == nil ? "Add Spot" : "Edit Spot")
        .onAppear {
            loadSpot()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func loadSpot() {
        if let spot = spotToEdit {
            name = spot.name
            notes = spot.notes
            rating = spot.rating
            hasCoffee = spot.hasCoffee
        }
    }

    func saveSpot() {
        if name.isEmpty {
            alertTitle = "Missing Information"
            alertMessage = "Please enter a name for the study spot."
            showAlert = true
            return
        }

        if let spot = spotToEdit {
            spot.name = name
            spot.notes = notes
            spot.rating = rating
            spot.hasCoffee = hasCoffee
            
        } else {
            let newSpot = StudySpot(
                name: name,
                notes: notes,
                icon: hasCoffee ? "cup.and.saucer.fill" : "book.fill",
                rating: rating,
                hasCoffee: hasCoffee
            )
            modelContext.insert(newSpot)

            name = ""
            notes = ""
            rating = 0
            hasCoffee = false
        }

        alertTitle = "Spot Saved"
        alertMessage = "The study spot was saved successfully."
        showAlert = true
    }
}
