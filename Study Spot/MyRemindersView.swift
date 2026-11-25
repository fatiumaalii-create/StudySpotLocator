//
//  MyRemindersView.swift
//  Study Spot
//
//  Created by apple on 16/11/2026.
//



import SwiftUI
import SwiftData
import UserNotifications

// Screen 9: My Reminders (one reminder for each study spot)
struct MyRemindersView: View {
    @Query private var spots: [StudySpot]

    var spotName: String = ""

    @State private var selectedSpotName = ""
    @State private var minutes = 30
    @State private var enableNotification = true

    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    let minuteOptions = [1, 5, 10, 30, 60, 120]

    // Names of all spots, for the Picker
    private var spotNames: [String] {
        var names: [String] = []
        for spot in spots {
            names.append(spot.name)
        }
        return names
    }

    // Only the spots that have a saved reminder
    private var reminderSpots: [StudySpot] {
        var result: [StudySpot] = []
        for spot in spots {
            if spot.reminderMinutes > 0 {
                result.append(spot)
            }
        }
        return result
    }

    var body: some View {
        Form {
            Section("Saved Reminders") {
                if reminderSpots.count == 0 {
                    Text("No reminders saved yet.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(reminderSpots) { spot in
                        HStack(spacing: 14) {
                            Image(systemName: spot.icon)
                                .font(.system(size: 28))
                                .foregroundColor(studyGreen)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(spot.name)
                                    .font(.headline)
                                Text("Reminder after \(spot.reminderMinutes) minutes")
                                    .font(.subheadline)
                                Text(spot.reminderNotification ? "Notification on" : "Notification off")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteReminders)

                    Text("Swipe left on a reminder to delete it.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            Section("Add / Edit Reminder") {
                Picker("Study Spot", selection: $selectedSpotName) {
                    ForEach(spotNames, id: \.self) { name in
                        Text(name)
                    }
                }

                Picker("Remind me in", selection: $minutes) {
                    ForEach(minuteOptions, id: \.self) { option in
                        Text("\(option) minutes")
                    }
                }

                Toggle("Enable notification", isOn: $enableNotification)

                Button("Save Reminder") {
                    saveReminder()
                }
            }
        }
        .navigationTitle("My Reminders")
        .onAppear {
            requestNotificationPermission()

            if spotName != "" {
                selectedSpotName = spotName
            } else if spots.count > 0 {
                selectedSpotName = spots[0].name
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func saveReminder() {
        // Find the spot that was chosen in the Picker (optionals lesson)
        var chosenSpot: StudySpot? = nil
        for spot in spots {
            if spot.name == selectedSpotName {
                chosenSpot = spot
            }
        }

        if let spot = chosenSpot {
            spot.reminderMinutes = minutes
            spot.reminderNotification = enableNotification

            if enableNotification {
                scheduleNotification(for: spot)
            } else {
                cancelNotification(for: spot)
            }

            alertTitle = "Reminder Saved"
            alertMessage = "Your reminder for \(spot.name) was saved."
        } else {
            alertTitle = "Missing Information"
            alertMessage = "Please choose a study spot."
        }

        showAlert = true
    }

    func deleteReminders(offsets: IndexSet) {
        for index in offsets {
            let spot = reminderSpots[index]
            cancelNotification(for: spot)
            spot.reminderMinutes = 0
            spot.reminderNotification = false
        }
    }

    // Unit 3.3: ask for permission
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in
            if granted {
                print("Permission granted")
            } else {
                print("Permission denied")
            }
        }
    }

    // Unit 3.3: schedule a local notification
    func scheduleNotification(for spot: StudySpot) {
        let content = UNMutableNotificationContent()
        content.title = "Study Reminder"
        content.body = "Time to study at \(spot.name)!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: Double(minutes * 60),
            repeats: false
        )

        // same identifier for the same spot, so saving again replaces the old one
        let request = UNNotificationRequest(
            identifier: spot.id.uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    func cancelNotification(for spot: StudySpot) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [spot.id.uuidString])
    }
}
