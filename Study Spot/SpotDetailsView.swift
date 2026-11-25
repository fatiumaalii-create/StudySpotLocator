//
//  SpotDetailsView.swift
//  Study Spot
//
//  Created by apple on 12/11/2026.
//

//
//  SpotDetailsView.swift
//  Study Spot
//

import SwiftUI
import SwiftData

// Screen 6: Spot details (same screen for the cafe, the library and added spots)
struct SpotDetailsView: View {
    var spot: StudySpot

    @State private var selectedDrink = "No drink"
    let drinks = ["No drink", "Americano", "Matcha", "Spanish Latte"]

    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Image(systemName: spot.icon)
                        .font(.system(size: 70))
                        .foregroundColor(studyGreen)
                        .padding(.vertical, 8)
                    Spacer()
                }
            }

            Section("Details") {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                    Text(spot.rating == 0 ? "Not rated yet" : "Rating: \(spot.rating)/5")
                }

                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(studyGreen)
                    Text(spot.notes)
                }

                HStack {
                    Image(systemName: "cup.and.saucer.fill")
                        .foregroundColor(studyGreen)
                    Text(spot.hasCoffee ? "Coffee available: Yes" : "Coffee available: No")
                }
            }

            Section("Drink Menu") {
                if spot.hasCoffee {
                    Text("Choose one drink before saving.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("A drink is optional for your library visit.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Unit 2.4: Picker
                Picker("Drink", selection: $selectedDrink) {
                    ForEach(drinks, id: \.self) { drink in
                        Text(drink)
                    }
                }
                .pickerStyle(.menu)

                if selectedDrink != "No drink" {
                    Text("Selected drink price: AED \(priceForDrink(selectedDrink))")
                        .bold()
                }

                // A cafe booking needs a drink, a library booking does not
                if spot.hasCoffee && selectedDrink == "No drink" {
                    Text("Pick a drink to save your booking.")
                        .foregroundColor(.gray)
                } else {
                    Button(spot.bookingSaved ? "Update Booking" : "Save Booking") {
                        saveBooking()
                    }
                }

                if spot.bookingSaved {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Booking saved")
                                .font(.headline)
                        }
                        .foregroundColor(studyGreen)

                        if spot.drinkBooked == "No drink" {
                            Text("No drink selected.")
                        } else {
                            Text("Selected drink: \(spot.drinkBooked)")
                            Text("Total: AED \(priceForDrink(spot.drinkBooked))")
                            Text("Pay at \(spot.name).")
                        }

                        Text("Enjoy your day!")
                            .bold()

                        Button("Cancel Booking") {
                            cancelBooking()
                        }
                        .foregroundColor(.red)
                    }
                }
            }

            Section {
                NavigationLink(destination: StudyMapView(spotName: spot.name)) {
                    HStack {
                        Image(systemName: "mappin")
                        Text("View on Map")
                    }
                    .foregroundColor(studyGreen)
                }

                NavigationLink(destination: MyRemindersView(spotName: spot.name)) {
                    HStack {
                        Image(systemName: "bell.fill")
                        Text("Set Reminder")
                    }
                    .foregroundColor(studyGreen)
                }
            }
        }
        .navigationTitle(spot.name)
        // Edit opens the Add / Edit Spot screen (screen 7)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddSpotView(spotToEdit: spot)) {
                    Text("Edit")
                }
            }
        }
        .onAppear {
            if spot.bookingSaved {
                selectedDrink = spot.drinkBooked
            }
        }
    }

    func saveBooking() {
        spot.drinkBooked = selectedDrink
        spot.bookingSaved = true
    }

    func cancelBooking() {
        spot.bookingSaved = false
        spot.drinkBooked = "No drink"
        selectedDrink = "No drink"
    }

    // Unit 1.4: switch
    func priceForDrink(_ drink: String) -> Int {
        switch drink {
        case "Americano":
            return 18
        case "Matcha":
            return 20
        case "Spanish Latte":
            return 25
        default:
            return 0
        }
    }
}
