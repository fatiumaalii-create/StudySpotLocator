//
//  MyRemindersView.swift
//  Study Spot
//
//  Created by apple on 16/11/2026.
//

import SwiftUI
import UserNotifications

struct MyRemindersView: View {

    @Environment(\.dismiss) private var dismiss

    var spotName: String? = nil

    @State private var selectedSpot = "Quiet Cafe"
    @State private var reminderDate = Date().addingTimeInterval(3600)
    @State private var enableNotification = false

    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    @AppStorage("reminder.cafe.date")
    private var cafeDate: Double = 0

    @AppStorage("reminder.library.date")
    private var libraryDate: Double = 0

    @AppStorage("reminder.cafe.notification")
    private var cafeNotification = false

    @AppStorage("reminder.library.notification")
    private var libraryNotification = false

    let studyBackground = Color(
        red: 238.0 / 255,
        green: 240.0 / 255,
        blue: 228.0 / 255
    )

    let studyGreen = Color(
        red: 28.0 / 255,
        green: 64.0 / 255,
        blue: 44.0 / 255
    )

    let studyText = Color(
        red: 16.0 / 255,
        green: 45.0 / 255,
        blue: 30.0 / 255
    )

    let fieldColor = Color(
        red: 251.0 / 255,
        green: 249.0 / 255,
        blue: 243.0 / 255
    )

    var body: some View {
        ZStack {
            studyBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {

                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }

                        Spacer()
                    }
                    .foregroundColor(studyGreen)

                    Text("My Reminders")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    // Saved reminders
                    if cafeDate == 0 && libraryDate == 0 {
                        Text("No reminders saved yet.")
                            .foregroundColor(.gray)
                            .padding()
                    }

                    if cafeDate > 0 {
                        reminderCard(
                            name: "Quiet Cafe",
                            icon: "cup.and.saucer.fill",
                            timestamp: cafeDate,
                            notification: cafeNotification
                        )
                    }

                    if libraryDate > 0 {
                        reminderCard(
                            name: "Campus Library",
                            icon: "building.columns.fill",
                            timestamp: libraryDate,
                            notification: libraryNotification
                        )
                    }

                    // Reminder form
                    VStack(alignment: .leading, spacing: 18) {

                        Text("Add / Edit Reminder")
                            .font(.headline)

                        Text("Study Spot")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Picker("Study Spot", selection: $selectedSpot) {
                            Text("Quiet Cafe")
                                .tag("Quiet Cafe")

                            Text("Campus Library")
                                .tag("Campus Library")
                        }
                        .pickerStyle(.menu)

                        DatePicker(
                            "Date",
                            selection: $reminderDate,
                            in: Date()...,
                            displayedComponents: .date
                        )

                        DatePicker(
                            "Time",
                            selection: $reminderDate,
                            displayedComponents: .hourAndMinute
                        )

                        Toggle(
                            "Enable notification",
                            isOn: $enableNotification
                        )

                        Text("Saving again updates this place’s reminder.")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Button(action: saveReminder) {
                            Text("Save Reminder")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(studyGreen)
                                .cornerRadius(16)
                        }
                    }
                    .padding(20)
                    .background(fieldColor)
                    .cornerRadius(20)
                }
                .padding(20)
            }
        }
        .foregroundColor(studyText)
        .tint(studyGreen)
        .navigationBarHidden(true)
        .onAppear {
            if let name = spotName,
               name == "Quiet Cafe" || name == "Campus Library" {
                selectedSpot = name
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

    func reminderCard(
        name: String,
        icon: String,
        timestamp: Double,
        notification: Bool
    ) -> some View {

        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(studyGreen)

            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .font(.headline)

                Text(
                    Date(timeIntervalSince1970: timestamp),
                    style: .date
                )

                Text(
                    Date(timeIntervalSince1970: timestamp),
                    style: .time
                )

                Text(
                    notification
                    ? "Notification scheduled"
                    : "Notification off"
                )
                .font(.caption)
                .foregroundColor(.gray)
            }

            Spacer()

            Button {
                deleteReminder(for: name)
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding(8)
            }
            .accessibilityLabel("Delete reminder for \(name)")
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(fieldColor)
        .cornerRadius(18)
    }

    func saveReminder() {

        guard reminderDate > Date() else {
            showMessage(
                title: "Check the time",
                message: "Please choose a future date and time."
            )
            return
        }

        let name = selectedSpot
        let date = reminderDate
        let center = UNUserNotificationCenter.current()

        if !enableNotification {
            center.removePendingNotificationRequests(
                withIdentifiers: [notificationID(for: name)]
            )

            storeReminder(
                name: name,
                date: date,
                notification: false
            )

            showMessage(
                title: "Reminder Saved",
                message: "Your reminder for \(name) is saved."
            )
            return
        }

        center.requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in

            if !granted || error != nil {
                DispatchQueue.main.async {
                    center.removePendingNotificationRequests(
                        withIdentifiers: [notificationID(for: name)]
                    )

                    storeReminder(
                        name: name,
                        date: date,
                        notification: false
                    )

                    showMessage(
                        title: "Reminder Saved",
                        message: """
                        Your reminder is saved without a notification. \
                        Allow notifications in iPhone Settings to receive alerts.
                        """
                    )
                }
                return
            }

            let content = UNMutableNotificationContent()
            content.title = "Study Reminder"
            content.body = "Time for your visit to \(name)."
            content.sound = .default

            let components = Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute, .second],
                from: date
            )

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: false
            )

            let request = UNNotificationRequest(
                identifier: notificationID(for: name),
                content: content,
                trigger: trigger
            )

            center.add(request) { schedulingError in
                DispatchQueue.main.async {
                    if schedulingError != nil {
                        showMessage(
                            title: "Could Not Save",
                            message: "Please try saving the reminder again."
                        )
                    } else {
                        storeReminder(
                            name: name,
                            date: date,
                            notification: true
                        )

                        showMessage(
                            title: "Reminder Saved",
                            message: """
                            Your reminder for \(name) is saved. \
                            You will receive a notification at the selected time.
                            """
                        )
                    }
                }
            }
        }
    }

    func storeReminder(
        name: String,
        date: Date,
        notification: Bool
    ) {
        if name == "Quiet Cafe" {
            cafeDate = date.timeIntervalSince1970
            cafeNotification = notification
        } else {
            libraryDate = date.timeIntervalSince1970
            libraryNotification = notification
        }
    }

    func notificationID(for name: String) -> String {
        if name == "Quiet Cafe" {
            return "studyReminder.cafe"
        } else {
            return "studyReminder.library"
        }
    }

    func deleteReminder(for name: String) {
        let center = UNUserNotificationCenter.current()
        let identifier = notificationID(for: name)

        center.removePendingNotificationRequests(
            withIdentifiers: [identifier]
        )

        center.removeDeliveredNotifications(
            withIdentifiers: [identifier]
        )

        if name == "Quiet Cafe" {
            cafeDate = 0
            cafeNotification = false
        } else {
            libraryDate = 0
            libraryNotification = false
        }
    }

    func showMessage(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

#Preview {
    NavigationStack {
        MyRemindersView()
    }
}
