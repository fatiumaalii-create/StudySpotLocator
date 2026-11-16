//
//  SpotDetailsView.swift
//  Study Spot
//
//  Created by apple on 12/11/2026.
//

import SwiftUI

struct SpotDetailsView: View {
    @Environment(\.dismiss) private var dismiss

    let icon: String
    let requiresDrink: Bool

    @AppStorage private var savedName: String
    @AppStorage private var savedNotes: String
    @AppStorage private var savedRating: Int
    @AppStorage private var confirmedDrink: String
    @AppStorage private var bookingSaved: Bool

    @State private var selectedDrink = ""
    @State private var showEdit = false
    @State private var draftName = ""
    @State private var draftNotes = ""
    @State private var draftRating = 0

    let studyBackground = Color(red: 238.0 / 255, green: 240.0 / 255, blue: 228.0 / 255)
    let studyGreen = Color(red: 28.0 / 255, green: 64.0 / 255, blue: 44.0 / 255)
    let studyText = Color(red: 16.0 / 255, green: 45.0 / 255, blue: 30.0 / 255)
    let fieldColor = Color(red: 251.0 / 255, green: 249.0 / 255, blue: 243.0 / 255)

    init(name: String, icon: String, notes: String, hasCoffee: Bool) {
        self.icon = icon
        self.requiresDrink = hasCoffee

        let key = "studySpot.\(name)"
        _savedName = AppStorage(wrappedValue: name, "\(key).name")
        _savedNotes = AppStorage(wrappedValue: notes, "\(key).notes")
        _savedRating = AppStorage(wrappedValue: 0, "\(key).rating")
        _confirmedDrink = AppStorage(wrappedValue: "", "\(key).confirmedDrink")
        _bookingSaved = AppStorage(wrappedValue: false, "\(key).bookingSaved")
    }

    var body: some View {
        ZStack {
            studyBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Label("Back", systemImage: "chevron.left")
                        }

                        Spacer()

                        Button("Edit") {
                            draftName = savedName
                            draftNotes = savedNotes
                            draftRating = savedRating
                            showEdit = true
                        }
                    }
                    .foregroundColor(studyGreen)

                    Text(savedName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Image(systemName: icon)
                        .font(.system(size: 70))
                        .foregroundColor(studyGreen)
                        .padding(.vertical, 8)

                    VStack(alignment: .leading, spacing: 12) {
                        Label(savedNotes, systemImage: "book.fill")

                        Label(
                            savedRating == 0 ? "Not rated yet" : "Rating: \(savedRating)/5",
                            systemImage: "star"
                        )
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(fieldColor)
                    .cornerRadius(16)

                    VStack(alignment: .leading, spacing: 14) {
                        Text("Drink Menu")
                            .font(.headline)

                        Text(requiresDrink
                             ? "Choose one drink before saving."
                             : "A drink is optional for your library visit.")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Picker("Drink", selection: $selectedDrink) {
                            Text(requiresDrink ? "Select a drink" : "No drink")
                                .tag("")
                            Text("Americano — AED 18").tag("Americano")
                            Text("Matcha — AED 20").tag("Matcha")
                            Text("Spanish Latte — AED 25").tag("Spanish Latte")
                        }
                        .pickerStyle(.menu)
                        .tint(studyGreen)

                        if let price = priceForDrink(selectedDrink) {
                            Text("Selected drink price: AED \(price)")
                                .fontWeight(.semibold)
                        }

                        Button(bookingSaved ? "Update Booking" : "Save Booking") {
                            confirmedDrink = selectedDrink
                            bookingSaved = true
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .foregroundColor(.white)
                        .background(
                            requiresDrink && selectedDrink.isEmpty
                                ? Color.gray
                                : studyGreen
                        )
                        .cornerRadius(12)
                        .disabled(requiresDrink && selectedDrink.isEmpty)

                        if bookingSaved {
                            VStack(alignment: .leading, spacing: 8) {
                                Label("Booking saved", systemImage: "checkmark.circle.fill")
                                    .font(.headline)
                                    .foregroundColor(studyGreen)

                                if let price = priceForDrink(confirmedDrink) {
                                    Text("Selected drink: \(confirmedDrink)")
                                    Text("Total: AED \(price)")
                                    Text("Pay at \(savedName).")
                                } else {
                                    Text("No drink selected.")
                                }

                                Text("Enjoy your day!")
                                    .fontWeight(.semibold)

                                Button("Cancel Booking", role: .destructive) {
                                    bookingSaved = false
                                    confirmedDrink = ""
                                    selectedDrink = ""
                                }
                            }
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(fieldColor)
                    .cornerRadius(16)

                    NavigationLink(destination: StudyMapView(
                        spotName: requiresDrink ? "Quiet Cafe" : "Campus Library",
                        showBack: true
                    )) {
                        Label("View on Map", systemImage: "mappin")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(studyGreen)
                            .cornerRadius(16)
                    }
                }
                .foregroundColor(studyText)
                .padding(20)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            selectedDrink = bookingSaved ? confirmedDrink : ""
        }
        .sheet(isPresented: $showEdit) {
            NavigationStack {
                Form {
                    TextField("Name", text: $draftName)
                    TextField("Notes", text: $draftNotes)

                    Picker("Rating", selection: $draftRating) {
                        Text("Not rated yet").tag(0)
                        Text("1/5").tag(1)
                        Text("2/5").tag(2)
                        Text("3/5").tag(3)
                        Text("4/5").tag(4)
                        Text("5/5").tag(5)
                    }
                }
                .navigationTitle("Edit Spot")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            showEdit = false
                        }
                    }

                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            savedName = draftName.trimmingCharacters(in: .whitespacesAndNewlines)
                            savedNotes = draftNotes
                            savedRating = draftRating
                            showEdit = false
                        }
                        .disabled(
                            draftName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        )
                    }
                }
                .tint(studyGreen)
            }
        }
    }

    func priceForDrink(_ drink: String) -> Int? {
        switch drink {
        case "Americano":
            return 18
        case "Matcha":
            return 20
        case "Spanish Latte":
            return 25
        default:
            return nil
        }
    }
}
#Preview {
    NavigationStack {
        SpotDetailsView(
            name: "Quiet Cafe",
            icon: "cup.and.saucer.fill",
            notes: "A cozy spot with great coffee and a calm atmosphere.",
            hasCoffee: true
        )
    }
}
